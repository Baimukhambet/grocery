import SwiftUI
import UIKit

protocol HomeViewProtocol {
    mutating func setProducts(products: Products)
}

struct HomeView: View {

    @StateObject var homeViewModel = HomeViewModel.shared
    let delegate: HomeViewDelegate
    
    var body: some View {
        ZStack {
            ScrollView() {
                VStack {
                    HeaderCell(product: homeViewModel.products.meals.randomElement() ?? Product(idIngredient: "1", strIngredient: "Loading", strDescription: "description"))

                    CategoryHeader(title: "Товары дня")
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 24) {
                            ForEach(homeViewModel.products.meals, id: \.self) {
                                product in
                                ProductCell(product: product)
                                    .onTapGesture {
                                        delegate.didTapOnProduct(title: "Apple")
                                    }
                            }
                        }
                    }
                    .padding(.leading, 16)
                    CategoryHeader(title: "Каталог")
                        .padding(.horizontal, 16)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(homeViewModel.products.meals, id: \.self) { card in
                            ProductCell(product: card)
                        }
                    }                    }
                }
            .scrollIndicators(.hidden)
                
                
            }
        }
    
    
    }


#Preview {
    HomeView(delegate: HomeViewController())
}
