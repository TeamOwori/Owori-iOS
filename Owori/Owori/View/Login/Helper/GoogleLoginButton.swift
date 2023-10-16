//
//  GoogleLoginButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 10/17/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleLoginButton: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isLoggedIn: Bool
    @Binding var alreadyMember: Bool
    
    var body: some View {
        GoogleSignInButton(action: loginViewModel.handleGoogleSignIn)
            .frame(width: 300, height: 44, alignment: .leading)
            .cornerRadius(12)
    }
}

func test() -> Void {
    
}

#Preview {
    GoogleLoginButton(isLoggedIn: .constant(false), alreadyMember: .constant(false))
        .environmentObject(UserViewModel())
        .environmentObject(LoginViewModel())
}
