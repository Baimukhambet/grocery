import SwiftUI

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    @Published var products: Products = Products(meals: [])
    @Published var productsOfDay: Products = Products(meals: [])
    @Published var favorites: Set<Product> = []
    @Published var topProduct: Product?

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
