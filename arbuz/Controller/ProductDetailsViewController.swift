import UIKit

class ProductDetailsViewController: UIViewController {
    let productService: ProductService = ProductService.shared
    let homeVM = HomeViewModel.shared
    let cartVM = CartViewModel.shared
    let id: String
    var product: Product?
    
    
    //MARK: Subviews
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        
        return imageView
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
        
        loadProduct()
    }
}


//MARK: Private functions
private extension ProductDetailsViewController {
    func loadProduct() {
        productService.fetchProduct(id: id) { product in
            if let product = product {
                
            }
        }
    }
}
