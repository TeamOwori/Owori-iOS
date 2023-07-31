//
//  LoginButton.swift
//  Owori
//
//  Created by 신예진 on 7/10/23.
//

import SwiftUI

struct LoginButton: View {
    // MARK: PROPERITES
    let buttonImage: String
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        
        //카카오 로그인
        HStack(alignment: .center, spacing: 15) {
            Button {
                // 버튼이 클릭되었을 때 실행되는 코드
                // 이 부분 코드 수정 필요함 (loginViewModel과 UserViewModel이 떨어져 있어야 함)
                // joinMember
                loginViewModel.kakaoLogin(oworiUser: userViewModel.user) {
                    if loginViewModel.isLoggedIn {
                        isLoggedIn = true
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
        LoginButton(buttonImage: "카카오로그인버튼", isLoggedIn: .constant(false))
        
    }
    
}

