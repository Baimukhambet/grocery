//
//  HeaderCell.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI

struct HeaderCell: View {
    var body: some View {

        HStack {
            Text("Специальное предложение")
                .padding(16)
                .font(.system(size: 22, weight: .semibold))
            
            ProductCell().padding(16)
            
        }
        .background(Color.yellow)
        .clipShape(.rect(cornerRadius: 16))
        
    }
}

#Preview {
    HeaderCell()
}
