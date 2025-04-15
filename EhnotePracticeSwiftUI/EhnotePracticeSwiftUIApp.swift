//
//  EhnotePracticeSwiftUIApp.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/24/25.
//

import SwiftUI

@main
struct EhnotePracticeSwiftUIApp: App {
    var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "LoginStatus")
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if isLoggedIn {
                    ConfigureUserView()
                        .navigationBarHidden(true)
                } else {
                    LoginView()
                }
            }
        }
    }
}
