import SwiftUI

struct MainView: View {
    // 1. Static data
    let itemPerRow: CGFloat = 2
    let horizontalSpacing: CGFloat = 16
    let height: CGFloat = 200
    
    // 2. Sample data for cards
    let cards: [Card] = MockStore.cards
    var body: some View {
        // 3. Use geometry to calculate width of the cards based on itemPerRow
        GeometryReader { geometry in
            ScrollView {
                // 4. Iterate cards and fillup in the VStack
                VStack(alignment: .leading, spacing: 8) {
                    HeaderView(imageUrl: URL(string: "https://c02.purpledshub.com/uploads/sites/41/2023/09/GettyImages_154514873.jpg?w=1029&webp=1")!)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.2)
                        .clipped()
                    ForEach(0..<cards.count) { i in
                        // 5. Process the first index of each row
                        if i % Int(itemPerRow) == 0 {
                            // 6. Get view
                            buildView(rowIndex: i, geometry: geometry)
                        }
                    }
                }
            }
        }
    }
    // 8. Iterate data and see if got more index
    func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
        var rowCards = [Card]()
        for itemIndex in 0..<Int(itemPerRow) {
            // 8. Check if got two item in counts, then insert it properly
            if rowIndex + itemIndex < cards.count {
                rowCards.append(cards[rowIndex + itemIndex])
            }
        }
        if !rowCards.isEmpty {
            let width = getWidth(geometry: geometry)
            return RowView(cards: rowCards, width: getWidth(geometry: geometry), height: width * 1.2, horizontalSpacing: horizontalSpacing)
        }
        
        return nil
    }
    
    func getWidth(geometry: GeometryProxy) -> CGFloat {
        let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
        return width
    }

}

struct CustomHeaderView: View {
    var body: some View {
        VStack {
            // Display product information (image, title, etc.)
            Text("Product Header")
                .font(.title)
                .padding()
            // Add other header content here
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue) // Customize header background color
        .foregroundColor(.white)
        .opacity(0.9) // Adjust opacity as needed
    }
}




#Preview {
    MainView()
}


