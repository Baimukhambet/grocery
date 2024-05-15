import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel.shared
    var body: some View {
        ZStack {
            ScrollView() {
                VStack {
                    HeaderCell()
//                    SearchTextField(txt: $homeViewModel.textSearch)
//                        .padding(.horizontal, 16)
                    CategoryHeader(title: "Товары дня")
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 24) {
                            ForEach(0...5, id: \.self) {
                                index in
                                ProductCell()
                            }
                        }
                    }
                    .padding(.leading, 16)
                    CategoryHeader(title: "Каталог")
                        .padding(.horizontal, 16)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(0...12, id: \.self) { card in
                            ProductCell()
                        }
                    }                    }
                }
            .scrollIndicators(.hidden)
                
                
            }
        }
    }


#Preview {
    HomeView()
}
