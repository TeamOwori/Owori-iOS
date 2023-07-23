//
//  InviteFamliy.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct InviteFamily: View {
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @State var isFifthViewActive: Bool = false
    // 임시로 true로 변경. 기본값 = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("가족그룹을 만들었어요.\n가족을 초대해볼까요?")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            Button {
                ShareLink(
                    item: URL(string: "https://developer.apple.com/xcode/swiftui/")!,
                        preview: SharePreview(
                            "SwiftUI",
                            image: Image("SwiftUI")
                        )
                )
            } label: {
                Text("초대코드 공유")
            }
            
            
            NavigationLink (value: 5) {
                Button {
                    isFifthViewActive = true
                } label: {
                    Text("임시 확인")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                BackToLoginButton(currentIndex: $currentIndex)
            }
            .navigationDestination(isPresented: $isFifthViewActive) {
                TermsOfUse(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
            
        }
        .onAppear {
                currentIndex = 4
        }
    }
}

struct InviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        InviteFamily(currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
