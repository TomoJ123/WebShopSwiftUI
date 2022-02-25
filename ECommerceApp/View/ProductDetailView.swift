//
//  ProductDetailView.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 10.02.2022..
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    // For Matched Geometry effect..
    var animation: Namespace.ID
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack {
            
            // Title Bar and Product Image...
            VStack {
                
                // Title Bar...
                HStack {
                    
                    Button {
                        // Closing View...
                        withAnimation(.easeInOut) {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(0.7))
                    }
                }
                .padding()
                
                //Product Image...
                // Adding Matched Geometry Effect
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            // Product details
            ScrollView(.vertical, showsIndicators: false) {
                
                // Product Data..
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(product.title)
                        .font(.system(size: 20).bold())
                        .foregroundColor(Color.black)
                    
                    Text(product.subtitle)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TV+ free for a year")
                        .font(.system(size: 16).bold())
                        .foregroundColor(Color.black)
                        .padding(.top)
                    
                    Text("Avaliable when you purchase any new Iphone, Ipad, iPod Touch, Mac or Apple TV, 4.99$/month after free trial.")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full description")
                        }
                        .font(.system(size: 15).bold())
                        .foregroundColor(Color("Purple"))
                    }
                    
                    HStack {
                        
                        Text("Total")
                            .font(.system(size: 17))
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.vertical, 20)
                    
                    //Add button..
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") to basket")
                            .font(.system(size: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("Purple")
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                
                //Corner radius only for top side...
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.cartProducts)
        .background(Color("HomeBG").ignoresSafeArea())
    }
    
    func isLiked() -> Bool {
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func isAddedToCart() -> Bool {
        return sharedData.cartProducts.contains { product in
            return self.product.id == product.id
        }
    }
    
    func addToLiked() {
        if let index = sharedData.likedProducts.firstIndex(where:  { product in
            return self.product.id == product.id
        }) {
            //Remove from liked...
            sharedData.likedProducts.remove(at: index)
        } else {
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart() {
        if let index = sharedData.cartProducts.firstIndex(where:  { product in
            return self.product.id == product.id
        }) {
            //Remove from liked...
            sharedData.cartProducts.remove(at: index)
        } else {
            // add to liked
            sharedData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
//            .environmentObject(SharedDataModel())
        EmptyView()
    }
}
