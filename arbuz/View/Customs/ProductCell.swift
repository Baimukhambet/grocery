//
//  ProductCell.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    let homeVM = HomeViewModel.shared
    let cartVM = CartViewModel.shared
    
    var onAddTap: (()->())?
    var onRemoveTap: (()->())?
    var onLikeTap: (()->())?
    var onCardTap: (()->())?
    var inCart: Bool
//    var amount: Int?
    
    let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    let mockPrice = 995
    let mockMin = 1
    let inFavorites = false
    
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 6) {

            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: "https://www.themealdb.com/images/ingredients/" + product.strIngredient! + ".png")!) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                
                
                
                Image(systemName: homeVM.isFavorite(product: product) ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(homeVM.isFavorite(product: product) ? Color.red : Color.black)
                
                    .scaledToFit()
                    .frame(width: 24)
                    .onTapGesture {
                        onLikeTap?()
                    }
            }
            Spacer()
            Text(product.strIngredient!)
                .font(.system(size: 18, weight: .medium))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text("\(product.price)₸/шт.")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                Group {
                    if inCart {
                        HStack {
                            cartVM.cart[product]! > 1 ? 
                            Image(systemName: "minus.circle").foregroundStyle(Color.white)
//                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                                .onTapGesture {
                                    onRemoveTap?()
                                }
                            : Image(systemName: "trash")
                                .foregroundStyle(Color.white)
//                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                                .onTapGesture {
                                    onRemoveTap?()
                                }
                            Text("\(cartVM.cart[product]!)шт.")
                                .foregroundStyle(Color.white)
                            Image(systemName: "plus.circle")
                                .foregroundStyle(Color.white)
                                .onTapGesture {
                                    onAddTap?()
                                }
//                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                        }
                    } else {
                        HStack(alignment: .center) {
                            Text("\(product.price)₸")
                                .foregroundStyle(Color.white)
                                .padding(.leading, 12)
                            Spacer()
                            
                            Image(systemName: "plus")
                                .foregroundStyle(Color.white)
                                .padding(.trailing, 12)
                        }
                        .onTapGesture {
                            onAddTap?()
                        }
                    }
                }
            }
            .tint(Color.green)
            .frame(width: 140, height: 40)
        }
        .padding(16)
        .background(Color(uiColor: backgroundColor))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ProductCell(product: Product(idIngredient: "1", strIngredient: "Lime", strDescription: "Description") as! ProductEntity, inCart: false)
}
