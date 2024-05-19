protocol AbstractProductService {
    func fetchProducts(completion: @escaping (Products) -> ());
}
