//
//  ProductButton.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 16.05.2024.
//

import SwiftUI

struct ProductButton: View {
    let isAdded = false

    var onAddTap: (()->())?
    
    var body: some View {
        HStack {
            Text(isAdded ? "More" : "Add")
                .foregroundStyle(Color.white)
        }
        
    }
}

#Preview {
    ProductButton()
}
