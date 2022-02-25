//
//  LoginPageViewModel.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 19.01.2022..
//

import SwiftUI

class LoginPageViewModel: ObservableObject {
    
    //login properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    //Register properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // log_status...
    @AppStorage("log_Status") var log_Status: Bool = false
    
    func login() {
        withAnimation {
            log_Status = true
        }
    }
    
    func register() {
        withAnimation {
            log_Status = true
        }
    }
    
    func forgotPassword() {
        
    }
}
