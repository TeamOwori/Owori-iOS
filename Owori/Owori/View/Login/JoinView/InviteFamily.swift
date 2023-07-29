//
//  InviteFamliy.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct InviteFamily: View {
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
                
                
                
                Button {
                    isFifthViewVisible = true
                    isCreateCodeViewVisible = false
                    isReceiveCodeViewVisible = false
                } label: {
                    Text("임시 확인")
                }
            }
            .onAppear {
                currentIndex = 4
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            BackToFamilyLinkViewButton(isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isCreateCodeViewVisible)
        }
    }
}

struct InviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        InviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""), isCreateCodeViewVisible: .constant(false), isReceiveCodeViewVisible: .constant(false), isFifthViewVisible: .constant(false))
    }
}
