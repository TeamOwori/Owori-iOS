//
//  LoginButton.swift
//  Owori
//
//  Created by 신예진 on 7/10/23.
//

import SwiftUI

struct LoginButton: View {
    // MARK: PROPERITES
    let buttonName: String
    let buttonFontStyle: String
    let fontColor: Color
    let buttonColor: Color
    
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
                print("Button tapped!")
            } label: {
                Text("\(buttonName)")
                    .font(
                        Font.custom("\(buttonFontStyle)", size: 15)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .top)
                    .foregroundColor(fontColor)
            }
            
        }
        .padding(20)
        .frame(width: 300, height: 44, alignment: .leading)
        .background(buttonColor)
        .cornerRadius(12)
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton(buttonName: "카카오 로그인", buttonFontStyle: "Apple SD Gothic Neo", fontColor: .black, buttonColor: .yellow)
    }
}

