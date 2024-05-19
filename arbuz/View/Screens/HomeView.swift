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
        ScrollView() {
            VStack {
                CategoryHeader(title: "Лучшее предложение")
                    .padding(.horizontal, 16)
                ProductCell(product: homeVM.topProduct ?? Product(idIngredient: "1", strIngredient: "a", strDescription: "d"), onCardTap: {
                    delegate.didTapOnProduct(product: homeVM.topProduct ?? Product(idIngredient: "1", strIngredient: "a", strDescription: "d"))
                })
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: UIApplication.windowSize!.height * 0.4, maxHeight: UIApplication.windowSize!.height * 0.4)
                    .padding(.horizontal, 16)
                
                CategoryHeader(title: "Товары дня")
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 24) {
                        ForEach(homeVM.productsOfDay.meals, id: \.self) {
                            product in
                            ProductCell(product: product,
                                        onCardTap: {
                                delegate.didTapOnProduct(product: product)
                            })
                            .frame(width: UIApplication.windowSize!.width * 0.4, height: UIApplication.windowSize!.width * 0.6)
                        }
                    }
                }
                .padding(.leading, 16)
                
                CategoryHeader(title: "Каталог")
                    .padding(.horizontal, 16)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(homeVM.products.meals, id: \.self) { product in
                        ProductCell(product: product, onCardTap: {
                            delegate.didTapOnProduct(product: product)
                        })
                        .frame(width: UIApplication.windowSize!.width * 0.5 - 30, height: UIApplication.windowSize!.width * 0.7)
                        
                    }
                }.padding(.horizontal, 16)                }
        }
        .scrollIndicators(.hidden)
        
        
        
    }
    
    
    
}


#Preview {
    HomeView(delegate: HomeViewController())
}
