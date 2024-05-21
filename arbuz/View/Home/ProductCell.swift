import SwiftUI

struct ProductCell: View {
    let product: Product
    @ObservedObject var homeVM = HomeViewModel.shared
    @ObservedObject var cartVM = CartViewModel.shared
    
    
    
    var onCardTap: (()->())?
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 6 ) {
            
            VStack {
                ZStack(alignment: .topTrailing) {
                    
                    MyAsyncImage(url: URL(string: product.imageUrl)!)
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    
                    
                    Image(systemName: homeVM.isFavorite(product: product) ? "heart.fill" : "heart")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(homeVM.isFavorite(product: product) ? Color.red : Color.black)
                    
                        .scaledToFit()
                        .frame(width: 24)
                        .onTapGesture {
                            homeVM.addToFavorites(product: product)
                        }
                }
                .padding(12)
                .background(Color(COLOR.secondary))
                .clipShape(.rect(cornerRadius: 16))
                
                Spacer()
                Text(product.strIngredient!)
                    .lineLimit(1)
                    .font(.system(size: FONTSIZE.titleBig, weight: .medium))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("\(product.price)₸/шт.")
                        .font(.system(size: FONTSIZE.titleMedium, weight: .semibold))
                        .foregroundColor(Color.gray)
                    
                    if !cartVM.inCart(product: product) {
                        Circle()
                            .fill(Color(COLOR.primary))
                            .frame(width: 4, height: 4)
                        Text("1 шт")
                            .font(.system(size: FONTSIZE.titleMedium, weight: .semibold))
                            .foregroundColor(Color(COLOR.primary))
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .onTapGesture {
                onCardTap?()
            }
            Spacer()
            
            
            ZStack {
                cartVM.inCart(product: product) ?
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(COLOR.primary))
                :
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(COLOR.defaultButton))
                
                Group {
                    if cartVM.inCart(product: product) {
                        HStack {
                            Button(action: {
                                cartVM.decrement(product: product)
                            }, label: {
                                cartVM.cart[product]! > 1 ?
                                Image(systemName: "minus")
                                    .font(Font.title3.weight(.bold))
                                    .foregroundColor(Color.white)
                                
                                : Image(systemName: "trash")
                                    .font(Font.title3.weight(.bold))
                                    .foregroundColor(Color.white)
                                
                            })
                            
                            Text("\(cartVM.cart[product]!)")
                                .font(.system(size: FONTSIZE.titleMedium, weight: .bold))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 10)
                            
                            
                            Button(action: {
                                cartVM.addToCart(product: product)
                            }, label: {
                                Image(systemName: "plus")
                                    .font(Font.title3.weight(.bold))
                                    .foregroundColor(Color.white)
                            })
                            
                            
                            
                        }
                    } else {
                        HStack(alignment: .center) {
                            Text("\(product.price) ₸")
                                .font(.system(size: FONTSIZE.titleMedium, weight: .bold))
                                .foregroundColor(Color.black)
                                .padding(.leading, 12)
                            
                            Spacer()
                            
                            Image(systemName: "plus")
                                .font(Font.title3.weight(.bold))
                                .foregroundColor(Color.green)
                                .padding(.trailing, 12)
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            cartVM.addToCart(product: product)
                        }
                    }
                }
            }
            //            .tint(Color.green)
            .frame(width: 140, height: 40)
        }
        .padding(16)
        
        
    }
}

#Preview {
    ProductCell(product: Product(idIngredient: "1", strIngredient: "Lime", strDescription: "Description"))
}
