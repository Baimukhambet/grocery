import Foundation
import UIKit

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
                    print("catch block executed.")
                    OfflineProductService.shared.fetchProducts { products in
                        //Put mock data in completion
                        self.products = products
                        
                        completion(products)
                        
                    }
                    
                }
            } else {
                print("catch block executed.")
                OfflineProductService.shared.fetchProducts { products in
                    //Put mock data in completion
                    self.products = products
                    
                    completion(products)
                    
                }
            }
        }.resume()
    }
    
    func fetchProduct(id: String, completion: @escaping (Product?) -> Void) {
        if let foundProduct = self.products.meals.first(where: { $0.idIngredient == id}) {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                completion(foundProduct)
            }
        } else {
            completion(nil)
        }
        
    }
    
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    guard let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }.resume()
        
    }
    
    
    
}
