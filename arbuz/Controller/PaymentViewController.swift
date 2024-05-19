//
//  PaymentViewController.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 17.05.2024.
//

import UIKit

class PaymentViewController: UIViewController {
    
    lazy var messageView: MessageView = {
        let messageView = MessageView(messageText: "Оплата прошла успешно!", buttonText: "Вернуться назад") {
            self.navigationController?.popViewController(animated: true)
        }
        messageView.translatesAutoresizingMaskIntoConstraints = false
        
        return messageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(messageView)
        messageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        messageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        messageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        messageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
}
