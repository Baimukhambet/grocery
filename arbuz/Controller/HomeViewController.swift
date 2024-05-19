import UIKit
import SwiftUI

protocol HomeViewDelegate {
    func didTapOnProduct(id: String);
    func getProducts()
}

final class HomeViewController: UIViewController, HomeViewDelegate {
    lazy var homeView = HomeView(delegate: self)
    let productService: ProductService = ProductService.shared
    let homeVM = HomeViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getProducts()
    }
    
    func didTapOnProduct(id: String) {
        productService.fetchProduct(id: id) { [self] product in
            if let product = product {
                DispatchQueue.main.async {
                    self.present(ProductDetailsViewController(product: product), animated: true)
                }
            }
        }
        
    }
    
    func getProducts() {
        productService.fetchProducts { products in
            DispatchQueue.main.async { [self] in
                if products.meals.count != 0 {
                    homeVM.topProduct = products.meals.first
                    homeVM.productsOfDay.meals = Array(products.meals[1...5])
                    homeVM.products.meals = Array(products.meals[6...products.meals.count - 1])
                }
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
    }
}
