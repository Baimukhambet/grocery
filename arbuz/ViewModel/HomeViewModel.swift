import SwiftUI

final class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    @Published var products: Products = Products(meals: [])
    @Published var productsOfDay: Products = Products(meals: [])
    @Published var favorites: Set<Product> = []
    @Published var topProduct: Product = Product(idIngredient: "1", strIngredient: "Mock Product", strDescription: "Description")
    
    private init() {}

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
