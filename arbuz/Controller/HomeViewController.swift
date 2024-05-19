import UIKit
import SwiftUI

protocol HomeViewDelegate {
    func didTapOnProduct(product: Product);
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
    
    func didTapOnProduct(product: Product) {
        print("tapped.")
        
//        navigationController?.pushViewController(ProductDetailsViewController(productTitle: title), animated: true)
        present(ProductDetailsViewController(product: product), animated: true)
    }
    
    func getProducts() {
        productService.fetchProducts { products in
            DispatchQueue.main.async {
                self.homeViewModel.products.meals = products.meals
                self.homeViewModel.topProduct = self.homeViewModel.products.meals.randomElement()
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
