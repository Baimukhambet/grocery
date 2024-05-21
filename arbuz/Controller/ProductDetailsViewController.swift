import UIKit
import Combine

final class ProductDetailsViewController: UIViewController {
    let productService: ProductService = ProductService.shared
    let homeVM = HomeViewModel.shared
    let cartVM = CartViewModel.shared
    let id: String
    var product: Product?
    
    
    //MARK: Subviews
    lazy var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        likeButton.imageView?.contentMode = .scaleAspectFit
        
        likeButton.addAction(UIAction{_ in self.likeTapped()}, for: .touchUpInside)
        
        return likeButton
    }()
    
    lazy var topBarView: UIView = {
        let closeButton = UIButton()
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.tintColor = .black
        closeButton.addAction(UIAction{ _ in self.dismiss(animated: true)}, for: .touchUpInside)
        
        let topBarView = UIView()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        
        topBarView.addSubview(closeButton)
        topBarView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            closeButton.leadingAnchor.constraint(equalTo: topBarView.leadingAnchor, constant: 8),
            closeButton.topAnchor.constraint(equalTo: topBarView.topAnchor, constant: 8),
            closeButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: -8),
            
            likeButton.trailingAnchor.constraint(equalTo: topBarView.trailingAnchor, constant: -8),
            likeButton.topAnchor.constraint(equalTo: topBarView.topAnchor, constant: 8),
            likeButton.bottomAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: -8),
        ])
        
        return topBarView
    }()
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        
        return imageView
    }()
    
    lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = COLOR.secondary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FONTSIZE.titleLarge, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buyButton: BuyButton = {
        let price = cartVM.inCart(product: product!) ? cartVM.cart[self.product!]! * self.product!.price : product!.price
        let qty = cartVM.inCart(product: product!) ? "\(cartVM.cart[self.product!]!)" : nil
        
        let btn = BuyButton(priceString: "\(price)", inCart: cartVM.inCart(product: product!), qtyString: qty)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.onMinus = {
            self.cartVM.decrement(product: self.product!)
            if self.cartVM.inCart(product: self.product!){
                let newPrice = self.cartVM.cart[self.product!]! * self.product!.price
                btn.setPriceLabel(price: "\(newPrice) ₸")
                let qty = self.cartVM.cart[self.product!]!
                btn.setQtyLabel(qty: "\(qty)")
            }
        }
        btn.onPlus = {
            self.cartVM.addToCart(product: self.product!)
            let newPrice = self.cartVM.cart[self.product!]! * self.product!.price
            btn.setPriceLabel(price: "\(newPrice) ₸")
            let qty = self.cartVM.cart[self.product!]!
            btn.setQtyLabel(qty: "\(qty)")
        }
        
        return btn
    }()
    
    
    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        loadProduct()
        
        
    }
    
    private var cancellables = Set<AnyCancellable>()
}


//MARK: Private functions
private extension ProductDetailsViewController {
    func setupView() {
        view.addSubview(topBarView)
        view.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageBackgroundView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            imageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: UIApplication.windowSize!.height * 0.5),
            
            productImageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: -16),
            productImageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor),
        ])
        
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        view.addSubview(productTitleLabel)
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 16),
            productTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    
    func loadProduct() {
        productService.fetchProduct(id: id) { product in
            if let product = product {
                self.product = product
                DispatchQueue.main.async {
                    self.productTitleLabel.text = product.strIngredient
                    self.setupButton()
                    self.subscribe()
                    
                    self.setupLikeButton()
                }
                
                self.fetchImage()
            }
        }
    }
    
    func fetchImage() {
        productService.loadImage(urlString: self.product!.imageUrl) { image in
            DispatchQueue.main.async {
                guard let image = image else {
                    self.setMockImage()
                    return
                }
                self.productImageView.image = image
            }
        }
    }
    
    func setMockImage() {
        guard let offlineImage = UIImage(named: product!.strIngredient!) else {
            productImageView.image = UIImage(systemName: "photo")
            return
        }
        productImageView.image = offlineImage
    }
    
    func setupButton() {
        self.view.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            buyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func subscribe() {
        cartVM.$cart.receive(on: RunLoop.main).sink { [self] _ in
            if(cartVM.inCart(product: product!)) {
                buyButton.addedToCart()
            } else {
                buyButton.removeFromCart()
            }
            
        }
        .store(in: &cancellables)
        
        homeVM.$favorites.receive(on: RunLoop.main).sink { [self] _ in
            if(homeVM.isFavorite(product: product!)) {
                likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            }
            
        }
        .store(in: &cancellables)
    }
    
    func setupLikeButton() {
        if(homeVM.isFavorite(product: product!)) {
            likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    func likeTapped() {
        homeVM.addToFavorites(product: product!)
    }
    

    
}
