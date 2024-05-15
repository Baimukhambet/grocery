//
//  SearchTextField.swift
//  arbuz
//
//  Created by Timur Baimukhambet on 15.05.2024.
//

import SwiftUI
import UIKit

struct SearchTextField: View {
    @Binding var txt: String
    let backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField("Type something", text: $txt)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 40)
        .padding(15)
        .background(Color(uiColor: backgroundColor))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    SearchTextField(txt: .constant(""))
}
