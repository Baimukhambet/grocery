import SwiftUI
import UIKit

final class TabView: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = HomeViewController()
        let cartVC = CartViewController()
        
        cartVC.goHomeTapped = {
            self.selectedIndex = 0
        }
        
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        let cartNavigationController = UINavigationController(rootViewController: cartVC)
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        cartNavigationController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 1)
        
        setViewControllers([homeNavigationController, cartNavigationController], animated: false)
        selectedIndex = 0
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = COLOR.primary
    }
}
