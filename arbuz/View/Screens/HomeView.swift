import SwiftUI
import UIKit

protocol HomeViewProtocol {
    mutating func setProducts(products: Products)
}

struct HomeView: View {

    @StateObject var cartVM = CartViewModel.shared
    @StateObject var homeVM = HomeViewModel.shared
    let delegate: HomeViewDelegate
    
    var body: some View {
        ZStack {
            ScrollView() {
                VStack {
                    HeaderCell(product: homeVM.products.meals.randomElement() ?? Product(idIngredient: "1", strIngredient: "Loading", strDescription: "description"))

                    CategoryHeader(title: "Товары дня")
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 24) {
                            ForEach(homeVM.products.meals, id: \.self) {
                                product in
                                ProductCell(product: product, onAddTap: {
                                    cartVM.addToCart(product: product)
                                }, onLikeTap: {cartVM.addToFavorites(product: product)}, inCart: cartVM.inCart(product: product))
                                    .onTapGesture {
                                        delegate.didTapOnProduct(product: product)
                                    }
                            }
                        }
                    }
                    .padding(.leading, 16)
                    CategoryHeader(title: "Каталог")
                        .padding(.horizontal, 16)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(homeVM.products.meals, id: \.self) { product in
                            ProductCell(product: product, onAddTap: {
                                cartVM.addToCart(product: product)
                            }, onLikeTap: {cartVM.addToFavorites(product: product)}, inCart: cartVM.inCart(product: product))
                                .onTapGesture {
                                    delegate.didTapOnProduct(product: product)
                                }

                        }
                    }                    }
                }
            .scrollIndicators(.hidden)
                
                
            }
        .ignoresSafeArea(.all, edges: [.horizontal])
    }
    
    
    
    }


#Preview {
    HomeView(delegate: HomeViewController())
}
