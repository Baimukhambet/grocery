import UIKit
import SwiftUI
import Combine

final class CartViewController: UIViewController {
    let cartVM = CartViewModel.shared
    var count = CartViewModel.shared.cart.count
    
    //MARK: Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartCollectionViewCell.self, forCellReuseIdentifier: CartCollectionViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
//    lazy var checkoutButton: UIButton = {
//        let btn = UIButton()
//        btn.setTitle("Перейти к оплате", for: .normal)
//        btn.backgroundColor = UIColor(red: 99/255, green: 206/255, blue: 100/255, alpha: 180)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.layer.cornerRadius = 12
//        return btn
//    }()
//    
    lazy var checkoutButton: CheckoutButton = CheckoutButton(titleText: "Перейти к оплате", amount: cartVM.cartAmount.description, onTap: {
        self.navigationController?.pushViewController(PaymentViewController(), animated: true)
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupTopBar()
        
        count = CartViewModel.shared.cart.count
        
        cartVM.$cart.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.checkoutButton.updateAmount(newValue: self?.cartVM.cartAmount.description ?? "Error")
            if self?.cartVM.cart.count != self?.count
            {
                self?.tableView.reloadData()
                self?.count = CartViewModel.shared.cart.count
            }
            
        }
        .store(in: &cancellables)
        
        cartVM.$cartIsEmpty.receive(on: RunLoop.main).sink { [weak self] result in
            if !result {
                self?.setupCheckoutButton()
            } else {
                DispatchQueue.main.async {
                    self?.checkoutButton.removeFromSuperview()
//                    self?.checkoutButton.alpha = 0.0
//                    self?.checkoutButton.isHidden = true
                }
//                self?.view.setNeedsLayout()
                print("CART IS EMPTY")
            }
        }.store(in: &cancellables)
    }
    
    var cancellables = Set<AnyCancellable>()
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //    }
    
}

//MARK: - Private Extensions

private extension CartViewController {
    func setupView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
//        setupCheckoutButton()
    }
    
    func setupTopBar() {
        navigationItem.title = "Корзина"
        let label = UILabel()
        label.text = "Очистить"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray.withAlphaComponent(0.7)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clearTapped))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    @objc func clearTapped() {
        cartVM.clearCart()
    }
    
    func setupCheckoutButton() {
        self.view.addSubview(checkoutButton)
        NSLayoutConstraint.activate([
            
            checkoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,  constant: -16),
            checkoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32)])
    }
}


//MARK: UITableView
extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartVM.cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCollectionViewCell.reuseId, for: indexPath) as! CartCollectionViewCell
        let products = Array(cartVM.cart.keys)
        cell.setupUI(product: products[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UIApplication.windowSize!.height * 0.2
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
