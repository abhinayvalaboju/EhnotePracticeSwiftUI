//
//  SplashView.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 4/8/25.
//

import SwiftUI

struct SplashView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @State private var loginResponse: LoginResponse?
    
    var body: some View {
        ZStack{
            Image("Splash_Dots")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing:10){
                Image("EhnoteWhiteLogo")
                    .resizable()
                    .frame(width: 60,height: 60)
                    .padding()
                Image("LoginHeaderLogo")
                    .resizable()
                    .frame(width: 180,height: 60)
            }
        }
        .background(Color(red: 24/255, green: 63/255, blue: 60/255).ignoresSafeArea())
        .onAppear {
            
        }
    }
    
    func loginApi(){
        
    }
}

#Preview {
    SplashView()
}
