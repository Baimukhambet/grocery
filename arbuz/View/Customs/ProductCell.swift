//
//  ProductCell.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    
    var onAddTap: (()->())?
    var onLikeTap: (()->())?
    var isHeader: Bool?
    
    let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    let mockPrice = 995
    let mockMin = 1
    @State var inCart = false
    @State var inFavorites = false
    
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
                
                
                
                Image(systemName: inFavorites ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(inFavorites ? Color.red : Color.black)
                
                    .scaledToFit()
                    .frame(width: 24)
                    .onTapGesture {
                        onLikeTap?()
                        inFavorites.toggle()
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
            HStack {
//                Text("$99.0")
//                    .font(.system(size: 18, weight: .bold))
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                Spacer()
                Button {
                    onAddTap?()
                    inCart.toggle()
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                        inCart ? HStack{
                            Text("Добавить")
                                .foregroundStyle(Color.white)
                            Image(systemName: "plus").renderingMode(.template).foregroundStyle(Color.white)
                        }
                        : HStack{
                            Text("ubrat")
                                .foregroundStyle(Color.white)
                            Image(systemName: "plus").renderingMode(.template).foregroundStyle(Color.white)
                        }
                    }
                    .tint(Color.green)
                    .frame(height: 40 )
                }
            }
        }
        .padding(16)
        .frame(width: 180, height: 280)
        .background(Color(uiColor: backgroundColor))
//        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.black, lineWidth: 1))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ProductCell(product: Product(idIngredient: "1", strIngredient: "Lime", strDescription: "Description"))
}
