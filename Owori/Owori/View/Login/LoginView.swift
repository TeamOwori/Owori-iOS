//
//  LoginView.swift
//  Owori
//
//  Created by 신예진 on 7/7/23.
//

import SwiftUI

struct SocialLoginStyle: Identifiable {
    let id: UUID
    let buttonImage: String
}

struct LoginView: View {
    let test1: [SocialLoginStyle] = [SocialLoginStyle(id: UUID(), buttonImage: "카카오로그인버튼"), SocialLoginStyle(id: UUID(), buttonImage: "애플로그인")]
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @State private var isLoggedIn: Bool = false
    @State private var alreadyMember: Bool = false
    
    var body: some View {
        VStack {
            Image("Login")
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .padding(EdgeInsets(top: 0, leading: -30, bottom: -30, trailing: 0))
            Text("모여봐요 우리 가족")
                .foregroundColor(Color.oworiGray600)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .bold()
            Image("오월이로고")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            VStack {
                KakaoLoginButton(isLoggedIn: $isLoggedIn, alreadyMember: $alreadyMember)
                AppleLoginButton(isLoggedIn: $isLoggedIn, alreadyMember: $alreadyMember)
                GoogleLoginButton(isLoggedIn: $isLoggedIn, alreadyMember: $alreadyMember)
            }
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
            Text("소셜로그인으로 가입시 이용약관 및 개인정보처리방침에 동의합니다.")
                .font(
                    Font.custom("Pretendard", size: 11)
                        .weight(.medium)
                )
                .padding(.top, 20)
                .kerning(0.11)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.oworiGray600)
        }
        .navigationDestination(isPresented: $isLoggedIn) {
            if alreadyMember {
                MainView(isLoggedIn: $isLoggedIn)
            } else {
                JoinNickname(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
