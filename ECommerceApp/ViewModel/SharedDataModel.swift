//
//  SharedDataModel.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 10.02.2022..
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    //Detail product Data..
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    // matched geometry effect from search page...
    @Published var fromSearchPage: Bool = false
    
    // Liked Products...
    @Published var likedProducts: [Product] = []
    
    // Basked Products..
    @Published var cartProducts: [Product] = []
    
    //calculating Total price
    func getTotalPrice() -> String {
        
        var total: Int = 0
        
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        
        return "\(total)"
    }
}
