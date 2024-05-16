//import Foundation
import Combine

final class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    private init(){}
    
    @Published var cart: Dictionary<Product, Int> = [:]
    @Published var favorites: Set<Product> = []
    
    func addToCart(product: Product) {
        if cart[product] != nil {
            cart[product]! += 1
        } else {
            cart[product] = 1
        }
    }
    
    func removeFromCart(product: Product) {
        if let value = cart[product] {
            if value > 1 {
                cart[product]! += 1
            } else {
                cart.removeValue(forKey: product)
            }
        } else {
            cart[product] = 1
        }
    }
    
    func inCart(product: Product) -> Bool {
        return cart[product] != nil
    }
    
    func isFavorite(product: Product) -> Bool {
        return favorites.contains(product)
    }
    
    func addToFavorites(product: Product) {
        if favorites.contains(product) {
            favorites.remove(product)
        } else {
            favorites.insert(product)
        }
    }
}
