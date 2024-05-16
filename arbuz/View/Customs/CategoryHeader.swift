//
//  CategoryHeader.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI

struct CategoryHeader: View {
    let title: String
    var body: some View {
        HStack{
            Text(title)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()        
        }
        .frame(height: 40)
    }
}

#Preview {
    CategoryHeader(title: "TITLE")
}
