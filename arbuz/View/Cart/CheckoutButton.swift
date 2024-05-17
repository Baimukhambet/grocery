//
//  CheckoutButton.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 17.05.2024.
//

import UIKit

class CheckoutButton: UIView {
    var onTap: (()->())
    let titleText: String
    let amount: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleText
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = amount + " ₸"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(titleText: String, amount: String, onTap: @escaping (()->())) {
        
        self.titleText = titleText
        self.amount = amount
        self.onTap = onTap
        super.init(frame: .zero)
        setupView()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(red: 99/255, green: 206/255, blue: 100/255, alpha: 140)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 22
        
        self.addSubview(titleLabel)
        self.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            amountLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            amountLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func buttonTapped() {
        onTap()
    }
    
    func updateAmount(newValue: String) {
        amountLabel.text = newValue + " ₸"
    }
    
}
