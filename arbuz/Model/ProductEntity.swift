import Foundation


class ProductEntity: Product {
//    lazy var price: Double = {
//        return Double.random(in: 100...10000)
//    }()
//    
    override init(idIngredient: String?, strIngredient: String?, strDescription: String?) {
        super.init(idIngredient: idIngredient, strIngredient: strIngredient, strDescription: strDescription)
    }
    
    required init(from decoder: any Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
