//
//  JoinNickname.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinNickname: View {
    @Binding var isLoggedIn: Bool
    @State private var currentIndex: Int = 1
    @State private var nickname: String = ""
    @State private var birthDateText: String = "11111111"
    @State private var familyName: String = ""
    @State private var inviteCode: String = ""
    @State private var isSecondViewActive = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            VStack(alignment: .leading) {
                Text("오월이에서 사용할\n닉네임을 입력해주세요.")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 0))
                Text("닉네임")
                    .foregroundColor(Color.oworiGray500)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
                HStack {
                    TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $nickname)
                        .onChange(of: nickname) { newText in
                            if newText.count > 7 {
                                nickname = String(newText.prefix(7))
                            }
                        }
                    Text("\(nickname.count)/7")
                }
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                .padding(.leading,20)
                .padding(.trailing,20)
                .foregroundColor(.gray)
                if nickname.isEmpty {
                    Text("한 글자 이상 입력해 주세요.")
                        .foregroundColor(.red)
                        .padding(.leading, 20)
                }
                Spacer()
                Button {
                    if !nickname.isEmpty {
                        isSecondViewActive = true
                    } else {
                        isSecondViewActive = false
                    }
                } label: {
                    Text("확인")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 52)
                }
                .background(Color.oworiOrange)
                .disabled(nickname.isEmpty)
            }
            .onAppear {
                currentIndex = 1
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isSecondViewActive) {
            TermsOfUse(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
        }
    }
}

struct JoinNickname_Previews: PreviewProvider {
    static var previews: some View {
        JoinNickname(isLoggedIn: .constant(false))
    }
}
