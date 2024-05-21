import Foundation
import UIKit

class Product: Decodable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.idIngredient == rhs.idIngredient
    }
    
    func hash(into hasher: inout Hasher) {}
    
    let idIngredient, strIngredient, strDescription: String?
    
    lazy var price: Int = {
        return Int.random(in: 10000...1000000) / 100
    }()
    
    var imageUrl: String {
        "https://www.themealdb.com/images/ingredients/\(strIngredient!).png"
    }
    
//    var image: UIImage?
    
    init(idIngredient: String?, strIngredient: String?, strDescription: String?) {
        self.idIngredient = idIngredient
        self.strIngredient = strIngredient
        self.strDescription = strDescription
        
//        loadImage { image in
//            self.image = image
//        }
    }
    
    func loadImage(completion: @escaping (UIImage)->()) {
        DispatchQueue.global().async {
            do {
                let image = try UIImage(data: Data(contentsOf: URL(string: self.imageUrl)!))
                completion(image!)
            } catch let e {
                completion(UIImage(systemName: "photo")!)
            }
        }
    }
}

struct Products: Decodable {
    var meals: [Product]
}
