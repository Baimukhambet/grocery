//
//  CartCollectionViewCell.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 16.05.2024.
//

import UIKit
import SwiftUI

class CartCollectionViewCell: UITableViewCell {
    
    var onPlusTap: (()->())?
    var product: Product?
    static let reuseId = "CartItem"
    
    lazy var cartItem = UIHostingController(rootView: CartItemView(product: product!))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(product: Product) {
        self.product = product
        super.init(style: .default, reuseIdentifier: CartCollectionViewCell.reuseId)
        setupUI()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.product = Product(idIngredient: "1", strIngredient: "Lemon", strDescription: "Description")
        setupUI()
    }
    
    
    
    
}

//MARK: Private Extension
private extension CartCollectionViewCell {
    func setupUI() {
        self.contentView.addSubview(cartItem.view)
        cartItem.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartItem.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cartItem.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cartItem.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cartItem.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
}
