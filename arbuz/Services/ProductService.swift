import Foundation

final class ProductService: AbstractProductService {
    static let shared = ProductService()
    private let BASE_URL_STRING = "https://www.themealdb.com/api/json/v1/1/list.php"
    
    private init() {}
    
    func fetchProducts(completion: @escaping (Products) -> ()) {
        var url = URL(string: BASE_URL_STRING)!
        url.append(queryItems: [URLQueryItem(name: "i", value: "list")])
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    var result = try JSONDecoder().decode(Products.self, from: data)
                    
                    result.meals = Array(result.meals[0...30])
                    result.meals.shuffle()
                    
                    completion(result)
                } catch let error {
                    completion(Products(meals: []))
                }
            }
        }.resume()
    }
    
    func fetchProduct() {
        
    }
}
