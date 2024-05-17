import UIKit
import SwiftUI
import Combine

final class CartViewController: UIViewController {
    let cartVM = CartViewModel.shared
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupTopBar()
        
        cartVM.$cart.receive(on: RunLoop.main).sink { [weak self] _ in
            self?.tableView.reloadData()}
        .store(in: &cancellables)
    }
    
    var cancellables = Set<AnyCancellable>()
    
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
    }
    
    func setupTopBar() {
        navigationItem.title = "Корзина"
        let label = UILabel()
        label.text = "Очистить"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray.withAlphaComponent(0.7)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
    }
}


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
}
