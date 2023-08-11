//
//  AppleLoginButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/11.
//

import SwiftUI

struct AppleLoginButton: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isLoggedIn: Bool
    // 서버에 등록되어있는 멤버인지 아닌지 체크
    @Binding var alreadyMember: Bool
    
    var body: some View {
        loginViewModel.appleLoginButton() {
            if loginViewModel.isLoggedIn {
                userViewModel.joinMember(socialToken: loginViewModel.socialToken) {
                    alreadyMember = userViewModel.user.is_service_member!
                    isLoggedIn = true
                }
            } else {
                isLoggedIn = false
            }
        }
    }
}


struct AppleLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleLoginButton(isLoggedIn: .constant(false), alreadyMember: .constant(false))
    }
}
