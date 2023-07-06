//
//  LoginView.swift
//  Owori
//
//  Created by 신예진 on 7/7/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
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
                
                //카카오 로그인
                HStack(alignment: .center, spacing: 15) {
                    Button(action: {
                                // 버튼이 클릭되었을 때 실행되는 코드
                                print("Button tapped!")
                            }) {
                                Text("카카오 로그인")
                                .font(
                                Font.custom("Apple SD Gothic Neo", size: 15)
                                .weight(.medium)
                                )
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .top)
                                .foregroundColor(.black.opacity(0.85))
                            }
                    
                }
                .padding(20)
                .frame(width: 300, height: 44, alignment: .leading)
                .background(Color(red: 1, green: 0.9, blue: 0))
                .cornerRadius(12)
                
            }
            .padding(0)
            
            //애플 로그인
            HStack(alignment: .center, spacing: 15) {
                Button(action: {
                            // 버튼이 클릭되었을 때 실행되는 코드
                            print("Button tapped!")
                        }) {
                            Text("Apple로 로그인")
                              .font(
                                Font.custom("SF Pro Display", size: 15)
                                  .weight(.medium)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity, minHeight: 18, maxHeight: 18, alignment: .top)
                        }
                
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .frame(width: 300, height: 44, alignment: .leading)
            .background(Color(red: 0.02, green: 0.03, blue: 0.03))
            .cornerRadius(12)
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


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
