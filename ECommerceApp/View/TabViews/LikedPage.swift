//
//  LikedPage.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 15.02.2022..
//

import SwiftUI

struct LikedPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete option
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    HStack {
                        Text("Favourites")
                            .font(.system(size: 28).bold())
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    
                    // checking if liked products are empty
                    if sharedData.likedProducts.isEmpty {
                        
                        Group {
                            
                            Image("NoLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            
                            Text("No favorites yet")
                                .font(.system(size: 25))
                                .foregroundColor(Color.black)
                                .fontWeight(.semibold)
                            
                            Text("Hit the like button on each product page to save favorite ones.")
                                .font(.system(size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        
                        // Display Products...
                        VStack(spacing: 15) {
    
                            // Designing
                            ForEach(sharedData.likedProducts) { product in
                                    
                                HStack(spacing: 0) {
                                    
                                    //animated because of line 33 toggle() with animation
                                    if showDeleteOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    CardView(product: product)
                                }
                            }
                                
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func CardView(product: Product) -> some View {
        
        HStack(spacing: 15) {
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.system(size: 18).bold())
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
                
                Text("Type: \(product.type.rawValue)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
    
    func deleteProduct(product: Product) {
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            
            let _ = withAnimation {
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
