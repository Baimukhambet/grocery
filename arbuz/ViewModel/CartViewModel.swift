//import Foundation
import Combine

final class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    private init(){}
    
    @Published var cart: Dictionary<Product, Int> = [:]
    
    var cartAmount: Int {
        cart.reduce(0) {$0 + $1.key.price * $1.value}
    }
    
    
    func addToCart(product: Product) {
        if cart[product] != nil {
            cart[product]! += 1
        } else {
            cart[product] = 1
        }
    }
    
    func decrement(product: Product) {
        if let value = cart[product] {
            if value > 1 {
                cart[product]! -= 1
            } else {
                cart.removeValue(forKey: product)
            }
        } else {
            return
        }
    }
    
    func removeFromCart(product: Product) {
        cart.removeValue(forKey: product)
    }
    
    func inCart(product: Product) -> Bool {
        return cart[product] != nil
    }
    
    func clearCart() {
        cart.removeAll()
    }

}
