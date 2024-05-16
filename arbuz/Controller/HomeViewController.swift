import UIKit
import SwiftUI

protocol HomeViewDelegate {
    func didTapOnProduct(title: String);
    func getProducts()
}

final class HomeViewController: UIViewController, HomeViewDelegate {
    lazy var homeView = HomeView(delegate: self)
    let productService: ProductService = ProductService.shared
    let homeViewModel = HomeViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getProducts()
    }
    
    func didTapOnProduct(title: String) {
        print("tapped.")
        
        navigationController?.pushViewController(ProductDetailsViewController(productTitle: title), animated: true)
//        present(ProductDetailsViewController(productTitle: title), animated: true)
    }
    
    func getProducts() {
        productService.fetchProducts { products in
            DispatchQueue.main.async {
                self.homeViewModel.products.meals = products.meals
            }
        }
    }
    

}

//MARK: - Private Extensions
extension HomeViewController {
    func setupView() {
        let homeViewHosting = UIHostingController(rootView: self.homeView)
        self.addChild(homeViewHosting)
        homeViewHosting.view.frame = self.view.bounds
        self.view.addSubview(homeViewHosting.view)
        homeViewHosting.didMove(toParent: self)
        navigationItem.title = "Главная"
//        navigationItem.largeTitleDisplayMode = .always
    }
}
