//
//  KakaoLoginButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/11.
//

import SwiftUI

struct KakaoLoginButton: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isLoggedIn: Bool
    @Binding var alreadyMember: Bool
    var body: some View {
        Button {
            loginViewModel.kakaoLogin(oworiUser: userViewModel.user) {
                if loginViewModel.isLoggedIn {
                    userViewModel.joinMember(socialToken: loginViewModel.socialToken) {
                        alreadyMember = userViewModel.user.is_service_member!
                        isLoggedIn = true
                    }
                } else {
                    isLoggedIn = false
                }
            }
        } label: {
            Image("카카오로그인버튼")
                .resizable()
                .frame(width: 300, height: 44, alignment: .leading)
                .cornerRadius(12)
        }
    }
}

struct KakaoLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        KakaoLoginButton(isLoggedIn: .constant(false), alreadyMember: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(LoginViewModel())
    }
}
