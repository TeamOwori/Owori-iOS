//
//  LoginView.swift
//  Owori
//
//  Created by 신예진 on 7/7/23.
//

import SwiftUI

struct SocialLoginStyle: Identifiable {
    let id: UUID
    let socialLoginName: String
    let fontStyle: String
    let fontColor: Color
    let buttonColor: Color
    
}

struct LoginView: View {
    let test1: [SocialLoginStyle] = [SocialLoginStyle(id: UUID(), socialLoginName: "카카오 로그인", fontStyle: "Apple SD Gothic Neo", fontColor: .black, buttonColor: .yellow), SocialLoginStyle(id: UUID(), socialLoginName: "Apple 로그인", fontStyle: "SF Pro Display", fontColor: .white, buttonColor: .black)]
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        // 배포 전 테스트시 !isLogined로 설정 (서버가 휴대폰에서는 안잡힘)
        if loginViewModel.isLoggedIn {
            JoinView()
        } else {
            VStack {
                //오월이 로고
                ZStack {
                    Image("Login")
                    //디자이너 피그마보고 설정했지만,이렇게 코드 짜면 안될 것 같음
                        .padding(.leading, -200)
                        .padding(.trailing, -154)
                        .padding(.top, 52)
                        .edgesIgnoringSafeArea(.top) // safe area를 고려하여 top 패딩 설정
                        .padding(.bottom, 410)
                }
                
                .frame(width: 400, height: 349.99988)
                
                //모여봐요 우리 가족 text
                Text("모여봐요 우리 가족")
                    .font(
                        Font.custom("Pretendard", size: 16)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.27))
                
                //오월이 이미지
                Image("owori")
                    .frame(width: 141.27937, height: 47.472)
                
                //소셜 로그인 버튼
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(test1) { item in
                        LoginButton(buttonName: item.socialLoginName, buttonFontStyle: item.fontStyle, fontColor: item.fontColor, buttonColor: item.buttonColor)
                    }
                }
                
                Text("소셜로그인으로 가입시 이용약관 및 개인정보처리방침에 동의합니다.")
                    .font(
                        Font.custom("Pretendard", size: 11)
                            .weight(.medium)
                    )
                    .kerning(0.11)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.38))
                
            }
        }
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
            .environmentObject(UserViewModel())
    }
}

