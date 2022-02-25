//
//  SearchView.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 27.01.2022..
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    //    Activate TextField with focus state
    @FocusState var startTF: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack(spacing: 20) {
                
                //Close button
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    
                    homeData.searchText = ""
                    //  Resetting...
                    sharedData.fromSearchPage = false
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                //Search Bar...
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    
                    Capsule()
                        .strokeBorder(Color("Purple"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom, 10)
            
            
            // Showing Progress if searching...
            // else showing no results found if empty...
            if let products = homeData.searchedProducts {
                
                if products.isEmpty {
                    // no results found...
                    VStack(spacing: 10) {
                        
                        //Picture is a little bit to the left so i will offset it!
                        Image("ItemNotFound")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                            .offset(x: 20)
                        
                        Text("Item Not Found")
                            .font(.system(size: 22).bold())
                            .foregroundColor(Color.black)
                        
                        Text("Try different search term or try looking for exact product.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding()
                    
                } else {
                    // filter results...
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0) {
                            //Found text..
                            Text("Found \(products.count) results")
                                .font(.system(size: 24).bold())
                                .foregroundColor(Color.black)
                                .padding(.vertical)
                            
                            StaggeredGrid(columns: 2, spacing: 20, list: products) { product in
                                // Card view..
                                ProductCardView(product: product)
                            }
                        }
                        .padding()
                    }
                }
                
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color("HomeBG")
                .ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        
        VStack(spacing: 10) {
            
            ZStack {
                
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            
            //Moving image to top to look like its fixed at half top..
                .offset(y: -50)
                .padding(.bottom, -50)
            
            Text(product.title)
                .font(.system(size: 18))
                .foregroundColor(Color.black)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color("Purple"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        .padding(.top, 50)
        //Showing Product detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
