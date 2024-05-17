//import Foundation
import Combine

final class CartViewModel: ObservableObject {
    static let shared = CartViewModel()
    private init(){}
    
    @Published var cart: Dictionary<Product, Int> = [:]
    
    
    func addToCart(product: Product) {
        if cart[product] != nil {
            cart[product]! += 1
        } else {
            cart[product] = 1
        }
    }
    
    func removeFromCart(product: Product) {
        print("REMOVING")
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
    
    func inCart(product: Product) -> Bool {
        return cart[product] != nil
    }

}
