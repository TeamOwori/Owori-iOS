//
//  JoinFamily.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinFamily: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    
    @State private var isJoinFamilyNameActive: Bool = false
    @State private var isReceiveCodeViewVisible: Bool = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            
            VStack{
                Text("가족 연결을 해주세요.")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 20))
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                
                
                Text("초대코드 받았나요?\n없다면 가족들에게 초대코드를 보내봐요!")
                    .foregroundColor(Color.oworiGray500)
                    .padding(EdgeInsets(top: -20, leading: 20, bottom: 8, trailing: 20))
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                
                Spacer()
                
                //초대코드 이미지
                Image("초대코드")
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
//                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 50, trailing: 0))
                
                Spacer()
                
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Button(action: {
                            // 버튼이 클릭되었을 때 실행되는 코드
                            isJoinFamilyNameActive = true
                        }) {
                            Text("초대 코드 만들게요")
                                .bold()
                                .foregroundColor(Color.white)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height*0.07, alignment: .center)
                            
                        }
                        .background(Color.oworiOrange)
                    }
                    .background(Color.oworiOrange)
                    .cornerRadius(12)
                    
                    HStack{
                        Button(action: {
                            // 버튼이 클릭되었을 때 실행되는 코드
                            isReceiveCodeViewVisible = true
                            print(isReceiveCodeViewVisible)
                        }) {
                            Text("초대 코드 받았어요")
                                .bold()
                                .foregroundColor(Color.oworiOrange)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height*0.07, alignment: .center)
                            
                        }
                        
                    }
                    .cornerRadius(12)
                    .background(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 1)
                            .stroke(Color.oworiOrange, lineWidth: 2)
                    )
                    
                }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 30, trailing: 50))
                
            }
            .onAppear {
                currentIndex = 3
            }
        }
        .navigationDestination(isPresented: $isJoinFamilyNameActive) {
            JoinFamilyName(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
//            InviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode, isCreateCodeViewVisible: $isJoinFamilyNameActive, isReceiveCodeViewVisible: $isReceiveCodeViewVisible)
        }
        .navigationDestination(isPresented: $isReceiveCodeViewVisible) {
            BeInviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode, isCreateCodeViewVisible: $isJoinFamilyNameActive, isReceiveCodeViewVisible: $isReceiveCodeViewVisible)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct JoinFamily_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamily(isLoggedIn: .constant(false), currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
