//
//  OnBoardingPage.swift
//  ECommerceApp
//
//  Created by Tomislav Arambašić on 19.01.2022..
//

import SwiftUI

struct OnBoardingPage: View {
    //Showing login page...
    @State var showLoginPage: Bool = false
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Find your\nGadget")
                .font(.system(size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("OnBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showLoginPage = true
                }
            } label: {
                
                Text("Get Started")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color.white)
                    .cornerRadius(10)
                    .foregroundColor(Color("Purple"))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()

        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("Purple")
        )
        .overlay(
            Group {
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
            .previewDevice("Iphone 13")
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
