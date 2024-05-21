import UIKit
import SwiftUI
import Combine

final class CartViewController: UIViewController {
    let cartVM = CartViewModel.shared
    var count = CartViewModel.shared.cart.count
    var goHomeTapped: (() -> ())?
    
    //MARK: Subviews
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartCollectionViewCell.self, forCellReuseIdentifier: CartCollectionViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        
        return tableView
    }()

    private lazy var checkoutButton: CheckoutButton = CheckoutButton(titleText: "Перейти к оплате", amount: cartVM.cartAmount.description, onTap: {
        self.checkoutButtonTapped()
    })
    
    private lazy var noItemsAlert: MessageView = {
        let messageView = MessageView(messageText: "Ваша корзина пока пуста", buttonText: "Перейти в каталог", onTap: {
            self.goHomeTapped!()
        })
        messageView.translatesAutoresizingMaskIntoConstraints = false
        return messageView
    }()
    
    private lazy var deliveryInfo: DeliveryInfoView = {
        let view = DeliveryInfoView(amount: 8000 - cartVM.cartAmount)
        
        return view
    }()
    
    
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
            
                self!.deliveryInfo.setAmount(amount: 8000 - self!.cartVM.cartAmount)
                self?.tableView.reloadSections(IndexSet(0..<1), with: .automatic)
        
            
        }
        .store(in: &cancellables)
        
        cartVM.$cartIsEmpty.receive(on: RunLoop.main).sink { [weak self] result in
            if !result {
                self?.setupCheckoutButton()
                self?.noItemsAlert.removeFromSuperview()
            } else {
                DispatchQueue.main.async {
                    self?.checkoutButton.removeFromSuperview()
                    self?.setupAlertLabel()
                }

                print("CART IS EMPTY")
            }
        }.store(in: &cancellables)
    }
    
    var cancellables = Set<AnyCancellable>()
}

//MARK: - Private Functions

private extension CartViewController {
    func setupView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
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
    
    func setupAlertLabel() {
        self.view.addSubview(noItemsAlert)
        noItemsAlert.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noItemsAlert.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        noItemsAlert.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        noItemsAlert.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        noItemsAlert.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func checkoutButtonTapped() {
        tableView.isHidden = true
        checkoutButton.isHidden = true
        let progressIndicator = UIActivityIndicatorView()
        progressIndicator.center = self.view.center
        self.view.addSubview(progressIndicator)
        progressIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [self] in
            self.navigationController?.pushViewController(PaymentViewController(), animated: true)
            progressIndicator.removeFromSuperview()
            cartVM.clearCart()
            tableView.isHidden = false
            checkoutButton.isHidden = false
        }

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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return DeliveryInfoView(amount: 8000 - cartVM.cartAmount)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if cartVM.cartAmount >= 8000 {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
}
