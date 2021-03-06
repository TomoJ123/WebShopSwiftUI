//
//  ContentView.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 19.01.2022..
//

import SwiftUI

struct ContentView: View {
    //Log status..
    @AppStorage("log_Status") var log_Status: Bool = false
    
    var body: some View {
        Group {
            if log_Status {
                MainPage()
            } else {
                OnBoardingPage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
