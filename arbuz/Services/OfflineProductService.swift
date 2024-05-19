class OfflineProductService: AbstractProductService {
    func fetchProducts(completion: @escaping (Products) -> ()) {
        let products = Products(meals: [
            Product(idIngredient: "1", strIngredient: "", strDescription: <#T##String?#>)
        ])
    }
    
    
}
