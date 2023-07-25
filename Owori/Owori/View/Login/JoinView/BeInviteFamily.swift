//
//  BeInviteFamily.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct BeInviteFamily: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @State private var isFifthViewActive: Bool = false
    // 임시로 true로 변경. 기본값 = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .padding(.top, 60)
            VStack(alignment: .leading) {
                
                Text("초대코드를 입력해주세요")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                
                HStack {
                    Text("초대코드 ")
                    TextField("", text: $inviteCode)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .foregroundColor(.gray)
                }
                
                NavigationLink (value: 5) {
                    Button {
                        if inviteCode == "testInvite" {
                            isFifthViewActive = true
                        } else {
                            isFifthViewActive = false
                        }
                    } label: {
                        Text("testInvite")
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    BackToLoginButton(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex)
                }
                .navigationDestination(isPresented: $isFifthViewActive) {
                    TermsOfUse(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
                }
            }
            .onAppear {
                currentIndex = 4
            }
        }
    }
}

struct BeInviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        BeInviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
