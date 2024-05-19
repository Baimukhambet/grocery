protocol AbstractProductService {
    func fetchProducts(completion: @escaping (Products) -> ());
    func fetchProduct(id: String, completion: @escaping (Product?) -> Void)
}
