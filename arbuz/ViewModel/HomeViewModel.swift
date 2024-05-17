import SwiftUI

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    @Published var textSearch: String = ""
    @Published var products: Products = Products(meals: [])
    
    @Published var favorites: Set<Product> = []
    
    
    
    
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
