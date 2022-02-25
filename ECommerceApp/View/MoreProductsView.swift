//
//  MoreProductsView.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 27.01.2022..
//

import SwiftUI

struct MoreProductsView: View {
    var body: some View {
        
        VStack {
            Text("More Products")
                .font(.system(size: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MoreProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductsView()
    }
}
