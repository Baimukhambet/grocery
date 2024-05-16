//
//  ProductCell.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    let homeViewModel = HomeViewModel.shared
    
    var onAddTap: (()->())?
    var onRemoveTap: (()->())?
    var onLikeTap: (()->())?
    var isHeader: Bool?
    var inCart: Bool
    
    let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    let mockPrice = 995
    let mockMin = 1
    let inFavorites = false
    
    var body: some View {
        VStack(spacing: 6) {

            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: "https://www.themealdb.com/images/ingredients/" + product.strIngredient! + ".png")!) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80)
                }
                
                
                
                Image(systemName: homeViewModel.isFavorite(product: product) ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(homeViewModel.isFavorite(product: product) ? Color.red : Color.black)
                
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
            Text("\(mockPrice)/шт.")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text("\(mockPrice)")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.black)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                Group {
                    if inCart {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundStyle(Color.white)
                                .onTapGesture {
                                    onRemoveTap?()
                                }
                            Text("1шт.")
                                .foregroundStyle(Color.white)
                            Image(systemName: "plus")
                                .foregroundStyle(Color.white)
                                .onTapGesture {
                                    onAddTap?()
                                }
                        }
                    } else {
                        HStack {
                            Text("Добавить")
                                .foregroundStyle(Color.white)
                            Image(systemName: "plus")
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            onAddTap?()
                        }
                    }
                }
                
            }
            .tint(Color.green)
            .frame(height: 40 )
                
            
        }
        .padding(16)
        .frame(width: 180, height: 280)
        .background(Color(uiColor: backgroundColor))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ProductCell(product: Product(idIngredient: "1", strIngredient: "Lime", strDescription: "Description"), inCart: false)
}
