//
//  Product.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 27.01.2022..
//

import SwiftUI


struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}

enum ProductType: String, CaseIterable {
    case wearable = "Wearable"
    case laptops = "Laptops"
    case phones = "Phones"
    case tablets = "Tablets"
}
