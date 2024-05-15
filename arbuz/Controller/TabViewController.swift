import SwiftUI
import UIKit

class TabView: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let mainVC = UIHostingController(rootView: HomeView())
        let cartVC = CartViewController()
        
//        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
//        cartVC.tabBarItem.image = UIImage(systemName: "cart.fill")
        mainVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house.fill"), tag: 0)
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart.fill"), tag: 1)
        
        setViewControllers([mainVC, cartVC], animated: false)
        selectedIndex = 0
    }
}
