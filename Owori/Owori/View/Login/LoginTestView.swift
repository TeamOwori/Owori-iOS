//
//  LoginTestView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/13.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser

struct LoginTestView: View {
    let buttonName: String = "카카오 로그인"
    let buttonFontStyle: String = "Apple SD Gothic Neo"
    let fontColor: Color = .black
    let buttonColor: Color = .yellow
    
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    
    
    
    var body: some View {
        
        
        
        VStack {
            // 로그인
            HStack(alignment: .center, spacing: 15) {
                Button {
                    loginViewModel.kakaoLogin()
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
            
            Text("\(loginViewModel.testUser?.kakaoAccount?.profile?.nickname ?? "nil")")

            //로그아웃
            HStack(alignment: .center, spacing: 15) {
                Button {
                    loginViewModel.handleKakaoLogout()
                } label: {
                    Text("카카오 로그아웃")
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
}

struct LoginTestView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTestView()
    }
}
