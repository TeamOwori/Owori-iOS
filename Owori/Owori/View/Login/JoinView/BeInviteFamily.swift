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
    @Binding var familyName: String
    @Binding var inviteCode: String
    @Binding var isCreateCodeViewVisible: Bool
    @Binding var isReceiveCodeViewVisible: Bool
    @Binding var isFifthViewVisible: Bool
    // 임시로 true로 변경. 기본값 = false
    
    var body: some View {
        VStack {
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
                
                Button {
                    if inviteCode == "testInvite" {
                        isFifthViewVisible = true
                        isCreateCodeViewVisible = false
                        isReceiveCodeViewVisible = false
                    } else {
                        isFifthViewVisible = false
                    }
                } label: {
                    Text("testInvite")
                }
                
            }
            .onAppear {
                currentIndex = 4
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            BackToFamilyLinkViewButton(isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isReceiveCodeViewVisible)
        }
    }
}

struct BeInviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        BeInviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""), isCreateCodeViewVisible: .constant(false), isReceiveCodeViewVisible: .constant(false), isFifthViewVisible: .constant(false))
    }
}
