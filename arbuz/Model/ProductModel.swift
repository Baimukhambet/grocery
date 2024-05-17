import Foundation

class Product: Decodable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.idIngredient == rhs.idIngredient
    }
    
    func hash(into hasher: inout Hasher) {}
    
    let idIngredient, strIngredient, strDescription: String?
    lazy var price: Int = {
        return Int.random(in: 10000...1000000) / 100
    }()
    
    init(idIngredient: String?, strIngredient: String?, strDescription: String?) {
        self.idIngredient = idIngredient
        self.strIngredient = strIngredient
        self.strDescription = strDescription
    }
}

struct Products: Decodable {
    var meals: [Product]
}
