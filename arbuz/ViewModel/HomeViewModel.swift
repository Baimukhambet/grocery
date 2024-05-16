import SwiftUI

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    @Published var textSearch: String = "" 
    
    @Published var products: Products = Products(meals: [])
}
