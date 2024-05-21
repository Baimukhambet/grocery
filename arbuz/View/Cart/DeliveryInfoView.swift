import UIKit

final class DeliveryInfoView: UIView {
    
    private var amount: Int

    private lazy var cargoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "cargo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
//        imageView.he.constraint(equalToConstant: 44)
        
       return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: FONTSIZE.titleMedium, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Бесплатная доставка, если вы добавите товаров ещё на \(amount) ₸ в корзину"
        
        return label
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = COLOR.secondary
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(amount: Int) {
        self.amount = amount
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(cargoIcon)
        backgroundView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            cargoIcon.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            cargoIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: cargoIcon.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -12),
        ])
    }
    
    func setAmount(amount: Int) {
        print("new value is \(amount)")
        self.amount = amount
        self.layoutIfNeeded()
    }

}


