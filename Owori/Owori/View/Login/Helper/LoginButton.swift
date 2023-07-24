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
    
    var body: some View {
        
        //카카오 로그인
        HStack(alignment: .center, spacing: 15) {
            Button {
                // 버튼이 클릭되었을 때 실행되는 코드
                loginViewModel.kakaoLogin(oworiUser: userViewModel.user) {
                    userViewModel.joinMember(socialToken: loginViewModel.socialToken)
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
        LoginButton(buttonImage: "카카오로그인버튼")
        
    }
    
}

