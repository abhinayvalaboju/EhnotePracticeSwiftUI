//
//  CustomLoaderView.swift
//  EhnotePracticeSwiftUI
//
//  Created by Abhinay Chary on 4/8/25.
//

import SwiftUI

struct CustomLoaderView: View {
    @State private var isAnimating = false

       var body: some View {
           ZStack {
               // Background overlay
               Color.black.opacity(0.4)
                   .ignoresSafeArea()

               // Rotating loader icon
               Image("loader_icon")
                   .resizable()
                   .frame(width: 50, height: 50)
                   .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                   .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimating)

               // Logo image overlaid
               Image("loader_logo")
                   .resizable()
                   .frame(width: 30, height: 30) // Adjust size to your logo image
           }
           .onAppear {
               isAnimating = true
           }
       }
}

#Preview {
    CustomLoaderView()
}
