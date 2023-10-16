//
//  LoginButton.swift
//  Owori
//
//  Created by 신예진 on 7/10/23.
//

import SwiftUI

struct LoginButton: View {
    let buttonImage: String
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isLoggedIn: Bool
    @Binding var alreadyMember: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
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
                Image(buttonImage)
                    .resizable()
                    .frame(width: 300, height: 44, alignment: .leading)
                    .cornerRadius(12)
            }
        }
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton(buttonImage: "카카오로그인버튼", isLoggedIn: .constant(false), alreadyMember: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(LoginViewModel())
    }
}

