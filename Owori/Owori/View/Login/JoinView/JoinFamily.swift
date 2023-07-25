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
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    
    @State private var isNextViewVisible: Bool = false
    @State private var createCodeViewVisible: Bool = false
    
    var body: some View {
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
                    isNextViewVisible = true
                    createCodeViewVisible = true
                } label: {
                    Text("초대 코드를 만들게요")
                }
                
                Button {
                    isNextViewVisible = true
                    createCodeViewVisible = false
                } label: {
                    Text("초대 코드를 받았어요")
                }
                
            }
            .onAppear {
                currentIndex = 4
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            BackToLoginButton(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex)
        }
        .navigationDestination(isPresented: $isNextViewVisible) {
            if createCodeViewVisible {
                InviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            } else {
                BeInviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
        }
    }
}

struct JoinFamily_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamily(isLoggedIn: .constant(false), currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
