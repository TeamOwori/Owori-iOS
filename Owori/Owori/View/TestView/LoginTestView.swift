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
    
    @EnvironmentObject  var loginViewModel: LoginViewModel
    @EnvironmentObject  var userViewModel: UserViewModel
    @EnvironmentObject  var storyViewModel: StoryViewModel
    @EnvironmentObject  var familyViewModel: FamilyViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // 로그인
                HStack(alignment: .center, spacing: 15) {
                    Button {
                        loginViewModel.kakaoLogin(oworiUser: userViewModel.user) {
                            userViewModel.joinMember(socialToken: loginViewModel.socialToken)
                        }
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
                
                loginViewModel.appleLoginButton()
                
                Text("\(userViewModel.user.member_id ?? "nil")")
                
                NavigationLink {
                    UserViewModelTestView()
                } label: {
                    Text("UserViewModel TestView")
                }
                
                NavigationLink {
                    FamilyViewModelTestView()
                } label: {
                    Text("FamilyViewModel TestView")
                }
                
                NavigationLink {
                    StoryViewModelTestView()
                } label: {
                    Text("StoryViewModelTestView TestView")
                }
                
                NavigationLink {
                    UserViewModelTestView()
                } label: {
                    Text("UserViewModel TestView")
                }
                
                
                
                
                
                
                
                
               
                
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
}

struct LoginTestView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTestView()
    }
}
