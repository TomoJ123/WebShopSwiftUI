//
//  HomeViewModel.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 27.01.2022..
//

import SwiftUI

// using Combine to monitor search field and if user leaves for .5 secs then starts searching...
// to avoid memory issue...

import Combine

class HomeViewModel: ObservableObject {
    
    @Published var productType: ProductType = .wearable
    
    @Published var products: [Product] = [
    
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series 7: Green", price: "$359", productImage: "appleWatch5"),
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "appleWatch6"),
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359", productImage: "appleWatch7"),
        
        Product(type: .phones, title: "Iphone 11", subtitle: "A15 - Pink", price: "$359", productImage: "iphone11"),
        Product(type: .phones, title: "Iphone 12", subtitle: "A15 - Pink", price: "$359", productImage: "iphone12"),
        Product(type: .phones, title: "Iphone 13", subtitle: "A15 - Pink", price: "$359", productImage: "iphone13"),
        Product(type: .phones, title: "Iphone 13", subtitle: "A15 - Pink", price: "$359", productImage: "iphone13"),
        
        Product(type: .laptops, title: "Macbook Pro", subtitle: "M1 - Gold", price: "$1359", productImage: "macbookPro"),
        Product(type: .laptops, title: "Macbook Air", subtitle: "M1 - Gold", price: "$1359", productImage: "macbookAir"),
        
        Product(type: .tablets, title: "iPad Air 2", subtitle: "A14 - Red", price: "$559", productImage: "ipad2"),
        Product(type: .tablets, title: "iPad Air 3", subtitle: "A14 - Red", price: "$559", productImage: "ipad3"),
        Product(type: .tablets, title: "iPad Air 4", subtitle: "A14 - Red", price: "$559", productImage: "ipad4")
    ]
    
    //Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More products on the type...
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init() {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType() {
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            //Limiting result..
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch() {
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
