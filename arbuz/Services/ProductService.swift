import Foundation

final class ProductService: AbstractProductService {

    //Singletone
    static let shared = ProductService()
    private let BASE_URL_STRING = "https://www.themealdb.com/api/json/v1/1/list.php"
    
    var products: Products = Products(meals: [])
    
    private init() {}
    
    func fetchProducts(completion: @escaping (Products) -> ()) {
        var url = URL(string: BASE_URL_STRING)!
        url.append(queryItems: [URLQueryItem(name: "i", value: "list")])
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                //Try to fetch products from API
                do {
                    var products = try JSONDecoder().decode(Products.self, from: data)
                    
                    products.meals = Array(products.meals[0...30])
                    products.meals.shuffle()
                    
                    self.products = products
                    
                    completion(products)
                } catch let error {
                    OfflineProductService.shared.fetchProducts { products in
                        //Put mock data in completion
                        self.products = products
                        
                        completion(products)
                        
                    }
                    
                }
            }
        }.resume()
    }
    
    func fetchProduct(id: String, completion: @escaping (Product?) -> Void) {
        if let foundProduct = self.products.meals.first(where: { $0.idIngredient == id}) {
            completion(foundProduct)
        } else {
            completion(nil)
        }
        
    }
    
    
    
}
