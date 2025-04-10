//
//  CustomNavBar.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 3/26/25.
//

import SwiftUI

struct CustomNavBar: View {
    var title: String = "Test Title"
    var showBackButton: Bool = true
    var showActionBtn : Bool = false
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back_button")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            if let actionTitle = actionTitle, let action = action {
                Button(action: action) {
                    Text(actionTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            } else {
                Spacer().frame(width: 44) // Keep alignment
            }
            
            
        }
        .padding()
        //           .background(Color.white.shadow(radius: 2))
        .background(Color(red: 24/255, green: 63/255, blue: 60/255))
    }
}

#Preview {
    CustomNavBar()
}
