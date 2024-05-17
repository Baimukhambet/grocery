//
//  CartItemView.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 17.05.2024.
//

import SwiftUI

struct CartItemView: View {
    var product: Product
    
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
                        .frame(minWidth: 0, maxWidth: 80, minHeight: 0, maxHeight: 80)
                }
                
                Image(systemName: "heart")
                    .padding([.top, .trailing], 8)
            }
            VStack(alignment: .leading) {
                //title
                Text(product.strIngredient ?? "No name")
                    .font(.system(size: 16))
                //price
                Text("\(product.price)kzt/шт")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray.opacity(0.8))
                //button
                HStack(spacing: 14) {
                    // Trash icon
                    Button(action: {
                        // Add your button action here
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                    }
                        
                    
//                    Spacer()
                    
                    // Weight text
                    Text("1")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                    
                    // Kg text

                    
//                    Spacer()
                    
                    // Plus button
                    Button(action: {
                        // Add your button action here
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(.rect(cornerRadius: 24))
//                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                .frame(width: 140, height: 60)
                
            }
            .padding(.leading, 8)
            Spacer()
            
            //delete button
            VStack(alignment: .trailing) {
                Image(systemName: "xmark")
                Spacer()
                Text("\(product.price) kzt")
                    .font(.system(size: 16, weight: .black))
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
