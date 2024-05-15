import SwiftUI
import UIKit

struct HeaderView: View {
    let imageUrl: URL

    var body: some View {
        VStack {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure(let error):
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }

     
            Text("Title text")
            Button(role: .none, action: {}) {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 40)
                        .foregroundStyle(.gray.opacity(0.3))
                    HStack {
                        Text("1000 kzt")
                            .foregroundStyle(.black)
                            .font(.system(size: 14, weight: .bold))
                        Image(systemName: "plus").renderingMode(.original).foregroundStyle(.green)
                    }
                }
            }
        }
    }
}

#Preview {
    HeaderView(imageUrl: URL(string: "https://www.allrecipes.com/thmb/1c99SWam7_FM6vUzpDDzIKffMR4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/ALR-strawberry-fruit-or-vegetable-f6dd901427714e46af2d706a57b9016f.jpg")!)
}
