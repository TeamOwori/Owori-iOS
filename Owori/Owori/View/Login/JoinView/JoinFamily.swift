//
//  JoinFamily.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinFamily: View {
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    
    @State private var isFourthOneViewActive: Bool = false
    @State private var isFourthTwoViewActive: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("가족 연결을 해주세요.")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            Text("초대코드 받았나요?\n없다면 가족들에게 초대코드를 보내봐요!")
                .foregroundColor(Color.oworiGray500)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            
            NavigationLink (value: 41) {
                Button {
                    isFourthOneViewActive = true
                } label: {
                    Text("초대 코드를 만들게요")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                BackToLoginButton(currentIndex: $currentIndex)
            }
            .navigationDestination(isPresented: $isFourthOneViewActive) {
                InviteFamily(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
            
            NavigationLink (value: 42) {
                Button {
                    isFourthTwoViewActive = true
                } label: {
                    Text("초대 코드를 받았어요")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isFourthTwoViewActive) {
                BeInviteFamily(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
        }
        .onAppear {
                currentIndex = 4
        }
    }
}

struct JoinFamily_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamily(currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
