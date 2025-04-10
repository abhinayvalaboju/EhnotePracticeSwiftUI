//
//  LoginView.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/24/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = true
    @State private var isLoggedIn = false
    @State private var showAlert = false
    @State private var isLoading = false
    
    @StateObject private var loginVM = LoginViewModel()
    @State private var loginResponse: LoginResponse?
    
    var body: some View {
        ZStack {
            Image("Splash_Dots")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing:20){
                Image("EhnoteWhiteLogo")
                    .resizable()
                    .frame(width: 60,height: 60)
                    .padding()
                Image("LoginHeaderLogo")
                    .resizable()
                    .frame(width: 180,height: 60
                    )
                
                VStack(spacing: 16){
                    TextField("Email", text: $email)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(5)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    
                    // Password TextField with "SHOW" Button
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Text(isPasswordVisible ? "HIDE" : "SHOW")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
  
                    // Login Button
                    Button(action: {
                        login()
                    }) {
                        Text("LOGIN")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color(red: 24/255, green: 63/255, blue: 60/255))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(5)
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text("Enter valid details"), dismissButton: .default(Text("OK")))
                    }
                    
                    Spacer()
                    Button(action: {
                        // Help action
                    }) {
                        HStack(spacing: 5) {
                            Text("Need Help")
                            Image(systemName: "questionmark.circle")
                        }
                        .foregroundColor(Color(red: 24/255, green: 63/255, blue: 60/255))
                    }
                    .padding(.top, 20)
                    
                }
                .padding()
                .background(Color.white)
                .fullScreenCover(isPresented: $isLoggedIn) {
                    ConfigureUserView()
                }
            }
            
            //To show the loader while API calls
            if isLoading {
                CustomLoaderView()
            }
                
        }
        .background(Color(red: 24/255, green: 63/255, blue: 60/255).ignoresSafeArea())
        
    }
        
    
    func login() {
        if(email == "" || password == ""){
//            Alert(title: Text(""),message: Text("Enter valid details"),dismissButton: .default(Text("Ok")))
            showAlert = true
        }else{
            UserDefaults.standard.setValue(email, forKey: "EmailID")
            UserDefaults.standard.setValue(password, forKey: "Password")
            
            showAlert = false
            isLoading = true
//            isLoggedIn = true
            loginVM.loginUser(email: email, password: password) { response in
                if(response != nil){
                    isLoading = false
                    loginResponse = response
                    if(loginResponse?.status ?? "" == "Failure"){
                        
                    }else{
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: "LoginStatus")
                        Constants.globalLoginResponse = response
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
