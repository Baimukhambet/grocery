import UIKit

final class CartViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartCollectionViewCell.self, forCellReuseIdentifier: CartCollectionViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupTopBar()
    }

}

//MARK: - Private Extensions

private extension CartViewController {
    func setupView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCollectionViewCell.reuseId, for: indexPath) as! CartCollectionViewCell
        
        return cell
    }
}
