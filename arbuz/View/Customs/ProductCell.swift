import SwiftUI

struct ProductCell: View {
    let product: Product
    let homeVM = HomeViewModel.shared
    let cartVM = CartViewModel.shared
    
    var onAddTap: (()->())?
    var onRemoveTap: (()->())?
    var onLikeTap: (()->())?
    var onCardTap: (()->())?
    var inCart: Bool
    //    var amount: Int?
    
//    let backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
//    let addButtonColor = Color.gray.opacity(0.1)
//    let addedButtonColor = Color(uiColor: UIColor(red: 83/255, green: 201/255, blue: 89/255, alpha: 1))
    
    var width: CGFloat?
    var height: CGFloat?
    
    var body: some View {
        VStack(spacing: 6) {
            
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: "https://www.themealdb.com/images/ingredients/" + product.strIngredient! + ".png")!) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                
                
                
                Image(systemName: homeVM.isFavorite(product: product) ? "heart.fill" : "heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(homeVM.isFavorite(product: product) ? Color.red : Color.black)
                
                    .scaledToFit()
                    .frame(width: 24)
                    .onTapGesture {
                        homeVM.addToFavorites(product: product)
                    }
            }
            .padding(12)
            .background(Color(uiColor: COLOR.secondary))
            .clipShape(.rect(cornerRadius: 16))
            
            Spacer()
            Text(product.strIngredient!)
                .lineLimit(1)
                .font(.system(size: FONTSIZE.titleBig, weight: .medium))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Text("\(product.price)₸/шт.")
                .font(.system(size: FONTSIZE.titleMedium, weight: .semibold))
                .foregroundStyle(Color.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            
            ZStack {
                cartVM.inCart(product: product) ?
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(uiColor: COLOR.primary))
                :
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(uiColor: COLOR.defaultButton))
                
                Group {
                    if cartVM.inCart(product: product) {
                        HStack {
                            Button(action: {
                                cartVM.decrement(product: product)
                            }, label: {
                                cartVM.cart[product]! > 1 ?
                                Image(systemName: "minus")
                                    .font(Font.title3.weight(.bold))
                                    .foregroundStyle(Color.white)
                                
                                : Image(systemName: "trash")
                                    .font(Font.title3.weight(.bold))
                                    .foregroundStyle(Color.white)
                                
                            })
                            
                            
                            Text("\(cartVM.cart[product]!)шт.")
                                .font(.system(size: FONTSIZE.titleMedium, weight: .bold))
                                .foregroundStyle(Color.white)
                            
                            Button(action: {
                                cartVM.addToCart(product: product)
                            }, label: {
                                Image(systemName: "plus")
                                    .font(Font.title3.weight(.bold))
                                    .foregroundStyle(Color.white)
                            })
                            
                            

                        }
                    } else {
                        HStack(alignment: .center) {
                            Text("\(product.price) ₸")
                                .font(.system(size: FONTSIZE.titleMedium, weight: .bold))
                                .foregroundStyle(Color.black)
                                .padding(.leading, 12)
                            
                            Spacer()
                            
                            Image(systemName: "plus")
                                .font(Font.title3.weight(.bold))
                                .foregroundStyle(Color.green)
                                .padding(.trailing, 12)
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            cartVM.addToCart(product: product)
                        }
                    }
                }
            }
            .tint(Color.green)
            .frame(width: 140, height: 40)
        }
        .padding(16)
                
        
    }
}

#Preview {
    ProductCell(product: Product(idIngredient: "1", strIngredient: "Lime", strDescription: "Description") as! ProductEntity, inCart: false)
}
