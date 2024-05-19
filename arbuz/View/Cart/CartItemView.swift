//
//  CartItemView.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 17.05.2024.
//

import SwiftUI

struct CartItemView: View {
    var product: Product
    @ObservedObject var cartVM = CartViewModel.shared
    @ObservedObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: "https://www.themealdb.com/images/ingredients/" + product.strIngredient! + ".png")!) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: 80)
                        .padding(12)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                        .frame(minWidth: 80, maxWidth: 80, minHeight: 0, maxHeight: 80)
                        .padding(12)
                    
                }
                
                Button {
                    homeVM.addToFavorites(product: product)
                } label: {
                    homeVM.isFavorite(product: product) ? Image(systemName: "heart.fill").renderingMode(.template).foregroundStyle(Color.red) : Image(systemName: "heart").renderingMode(.template).foregroundStyle(Color.black)
                }
                    .padding([.top, .trailing], 8)
            }
            VStack(alignment: .leading) {
                //title
                Text(product.strIngredient ?? "No name")
                    .font(.system(size: FONTSIZE.titleMedium))
                //price
                Text("\(product.price)₸/шт")
                    .font(.system(size: FONTSIZE.titleSmall))
                    .foregroundStyle(Color.gray.opacity(0.8))
                //button
                HStack(spacing: 14) {
                    // Trash icon
                    Button(action: {
                        cartVM.decrement(product: product)
                    }) {
                        cartVM.cart[product] ?? 0 > 1 ?
                        Image(systemName: "minus")
                            .font(Font.title3.weight(.semibold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        :
                        Image(systemName: "trash")
                            .font(Font.title3.weight(.semibold))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    }
                        
                    // Weight text
                    Text("\(cartVM.cart[product] ?? 0)")
                        .foregroundColor(.black)
                        .font(.system(size: FONTSIZE.titleMedium, weight: .medium))
                    
                    // Plus button
                    Button(action: {
                        cartVM.addToCart(product: product)
                    }) {
                        Image(systemName: "plus")
                            .font(Font.title3.weight(.semibold))
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 24))
//                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .frame(width: 160, height: 50)
                
            }
            .padding(.leading, 8)
            Spacer()
            
            //delete button
            VStack(alignment: .trailing) {
                Button {
                    cartVM.removeFromCart(product: product)
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.black)
                Spacer()
                Text("\(product.price * (cartVM.cart[product] ?? 1)) ₸")
                    .font(.system(size: FONTSIZE.titleMedium, weight: .black))
                    .foregroundStyle(Color.black.opacity(0.75))
            }
            .padding(.bottom, 14)
            
            //price
            
        }
        .frame(height: 100)
    }
}

#Preview {
    CartItemView(product: Product(idIngredient: "1", strIngredient: "Lime", strDescription: "Description"))
}
