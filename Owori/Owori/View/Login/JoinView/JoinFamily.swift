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
                    .padding(.top, 60)
                VStack(alignment: .leading) {
                    Text("가족 연결을 해주세요.")
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                    Text("초대코드 받았나요?\n없다면 가족들에게 초대코드를 보내봐요!")
                        .foregroundColor(Color.oworiGray500)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    
                    Button {
                        isCreateCodeViewVisible = true
                    } label: {
                        Text("초대 코드를 만들게요")
                    }
                    
                    Button {
                        isReceiveCodeViewVisible = true
                    } label: {
                        Text("초대 코드를 받았어요")
                    }
                    
                }
                .onAppear {
                    currentIndex = 4
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isFifthViewVisible) {
                TermsOfUse(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
        }
        
    }
}

struct JoinFamily_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamily(isLoggedIn: .constant(false), currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
