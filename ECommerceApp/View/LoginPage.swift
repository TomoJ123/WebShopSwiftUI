//
//  LoginPage.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 19.01.2022..
// 8:48 

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageViewModel = LoginPageViewModel()
    
    var body: some View {
     
        VStack() {
            
            //Welcome back screen for 3 half of the screen
            VStack {
                Text("Welcome\nback")
                    .font(.system(size: 55).bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height / 3.5)
                    .padding()
                    .background(
                        
                        ZStack {
                            LinearGradient(colors: [
                                Color("LoginCircle"),
                                Color("LoginCircle")
                                    .opacity(0.8),
                                Color("Purple")
                            ], startPoint: .top, endPoint: .bottom)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(.trailing)
                                .offset(y: -25)
                                .ignoresSafeArea()
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 23, height: 23)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading, 30)
                        }
                    )
                
            }
            .frame(height: getRect().height / 3.5)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                //Login page form
                VStack(spacing: 15) {
                    
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.system(size: 22).bold())
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    customTextField(icon: "envelope", title: "Email", hint: "test@gmail.com", value: $loginData.password, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    customTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.email, showPassword: $loginData.showPassword)
                        .padding(.top, 10)

                    //Register reenter password
                    if loginData.registerUser {
                        customTextField(icon: "lock", title: "Re-Enter Password", hint: "12345", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //Forgot password
                    Button {
                        loginData.forgotPassword()
                    } label: {
                        
                        Text("Forgot password?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Login button
                    Button {
                        if loginData.registerUser {
                            loginData.register()
                        } else {
                            loginData.login()
                        }
                    } label: {
                        
                        Text("Login")
                            .font(.system(size: 14).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    //Register User Button
                    Button {
                        loginData.registerUser.toggle()
                    } label: {
                        
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top, 8)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                //Applying custom corners
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        
        // Clearing data when changes...
        // Optional
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
        
    }
    
    @ViewBuilder
    func customTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        
        // Show button for password fields
        .overlay(
            
            Group {
                
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13).bold())
                            .foregroundColor(Color("Purple"))
                    })
                        .offset(y: 8)
                }
            }
            
            , alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
