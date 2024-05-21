import UIKit

final class BuyButton: UIView {
    private var priceString: String
    private var qtyString: String?
    private var inCart: Bool {
        didSet {
            inCart ? showInCart() : showInactive()
        }
    }
    
    var onPlus: (() -> ())?
    var onMinus: (() -> ())?
    
    private var priceFormatted: String {
        priceString + " ₸"
    }
    
    init(priceString: String, inCart: Bool, qtyString: String?) {
        self.priceString = priceString
        self.qtyString = qtyString
        self.inCart = inCart
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FONTSIZE.titleLarge, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var qtyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FONTSIZE.titleBig, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    private lazy var plusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
        imageView.tintColor = .white
        
        return imageView
    }()
    
    private lazy var minusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .bold))
        imageView.tintColor = .white
        
        return imageView
    }()
    
    lazy var plusLeadingAnch = plusIcon.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let viewWidth = self.bounds.width
        
        if(!inCart) {
            onPlus?()
        } else {
            if location.x < viewWidth / 2 {
                onMinus?()
            } else {
                onPlus?()
            }
        }
    }
    
    func addedToCart() {
        self.inCart = true
    }
    
    func removeFromCart() {
        self.inCart = false
    }
    
    func setPriceLabel(price: String) {
        self.priceLabel.text = price
    }
    
    func setQtyLabel(qty: String) {
        self.qtyLabel.text = qty
    }

}


private extension BuyButton {
    func setupView() {
        self.backgroundColor = COLOR.primary
        priceLabel.text = priceFormatted
        qtyLabel.text = (qtyString != nil) ? qtyString :  "за шт"
        
        self.addSubview(priceLabel)
        self.addSubview(qtyLabel)
        self.addSubview(plusIcon)
        
        inCart ? setupForCart() : setupForInitial()
    }
    
    func showInCart() {
        setupForCart()
    }
    
    func showInactive() {
        minusIcon.removeFromSuperview()
        qtyLabel.text = "за шт"
        setupForInitial()
    }
    
    func setupForInitial() {
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            qtyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            qtyLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            
//            plusIcon.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16),
            plusLeadingAnch,
            plusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
    }
    
    func setupForCart() {
        self.addSubview(minusIcon)
        plusLeadingAnch.isActive = false
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            qtyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            qtyLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            
            plusIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            plusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            minusIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            minusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
    }
}
