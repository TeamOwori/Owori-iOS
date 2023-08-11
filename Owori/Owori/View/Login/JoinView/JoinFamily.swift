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
    
    @State private var isCreateCodeViewVisible: Bool = false
    @State private var isReceiveCodeViewVisible: Bool = false
    @State private var isFifthViewVisible: Bool = false
    
    var body: some View {
        if isCreateCodeViewVisible && !isFifthViewVisible {
            InviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode, isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isReceiveCodeViewVisible, isFifthViewVisible: $isFifthViewVisible)
        } else if isReceiveCodeViewVisible && !isFifthViewVisible {
            BeInviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode, isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isReceiveCodeViewVisible, isFifthViewVisible: $isFifthViewVisible)
        } else {
            VStack {
                NumberIndicator(currentIndex: $currentIndex)
                    .offset(y: 0)
                VStack(alignment: .leading) {
                    Text("가족 연결을 해주세요.")
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    
                    
                    Text("초대코드 받았나요?\n없다면 가족들에게 초대코드를 보내봐요!")
                        .foregroundColor(Color.oworiGray500)
                        .padding(EdgeInsets(top: -20, leading: 20, bottom: 8, trailing: 20))
                    
                    //초대코드 이미지
                    Image("초대코드")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 50, trailing: 0))
                        
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(alignment: .center, spacing: 16) {
                            Button(action: {
                                // 버튼이 클릭되었을 때 실행되는 코드
                                isCreateCodeViewVisible = true
                                print(isCreateCodeViewVisible)
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
                        
                        HStack(alignment: .center, spacing: 0) {
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
                    .padding(EdgeInsets(top: 10, leading: 50, bottom: 30, trailing: 50))
                    
                }
                .onAppear {
                    currentIndex = 4
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isFifthViewVisible) {
                TermsOfUse(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                }
//            }
        }
    }
}

struct JoinFamily_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamily(isLoggedIn: .constant(false), currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
