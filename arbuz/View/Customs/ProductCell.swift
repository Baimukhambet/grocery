//
//  ProductCell.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI

struct ProductCell: View {
    
    var onAddTap: (()->())?
    var onLikeTap: (()->())?
    var isHeader: Bool?
    
    let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    var body: some View {
        VStack {
            HStack(alignment: .top){
                Spacer()
                    .frame(width: 24)
                Image("apple")
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 80)
                
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .onTapGesture {
                        onLikeTap?()
                    }
            }
            Spacer()
            Text("Some Product")
                .font(.system(size: 16, weight: .bold))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text("1 шт.")
                .font(.system(size: 16, weight: .semibold))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Text("$99.0")
                    .font(.system(size: 18, weight: .bold))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button {
                    onAddTap?()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                        Image(systemName: "plus").renderingMode(.template).foregroundStyle(Color.white)
                    }
                    .tint(Color.green)
                    .frame(width: 40, height: 40)
                }
            }
        }
        .padding(16)
        .frame(width: 180, height: 210)
        .background(Color(uiColor: backgroundColor))
//        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.black, lineWidth: 1))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    ProductCell()
}
