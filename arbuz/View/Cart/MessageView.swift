import UIKit

final class MessageView: UIView {
    let messageText: String
    let buttonText: String
    let onTap: (()->())
    
    //MARK: -Subviews
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = messageText
        label.font = .systemFont(ofSize: FONTSIZE.titleLarge, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle(buttonText, for: .normal)
        button.backgroundColor = UIColor(red: 99/255, green: 206/255, blue: 100/255, alpha: 140)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: button.intrinsicContentSize.width + 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: button.intrinsicContentSize.height + 10).isActive = true
        button.titleLabel?.font = .systemFont(ofSize: FONTSIZE.titleMedium, weight: .bold)
//        button.canBecomeFirstResponder = true
        
        button.addAction(UIAction{_ in
            print("BUtton has been tapped")
            self.onTap()
        }, for: .touchUpInside)
        return button
    }()
    
    //MARK: Init
    init(messageText: String, buttonText: String, onTap: @escaping () -> Void) {
        self.messageText = messageText
        self.buttonText = buttonText
        self.onTap = onTap
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(messageLabel)
        self.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            actionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
    
}
