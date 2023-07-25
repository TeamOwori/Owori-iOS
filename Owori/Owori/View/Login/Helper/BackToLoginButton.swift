//
//  BackToLoginButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/24.
//

import SwiftUI

struct BackToLoginButton: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        
        if 1 <= currentIndex && currentIndex <= 5 {
            Button {
                isLoggedIn = false
            } label: {
                Text("X")
            }
        }
    }
}

struct BackToLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        BackToLoginButton(isLoggedIn: .constant(true), currentIndex: .constant(1))
            .environmentObject(LoginViewModel())
    }
}
