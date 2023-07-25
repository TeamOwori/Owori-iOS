//
//  JoinNickname.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinNickname: View {
    
    @State private var currentIndex: Int = 1
    
    // First
    @State private var nickname: String = ""
    
    // Second
    @State private var birthDateText: String = ""
    @State private var previousBirthDateText: String = ""
    
    // Third
    @State private var familyName: String = ""
    
    // Fourth
    @State private var inviteCode: String = ""
    
    @State private var isSecondViewActive = false
    var body: some View {
        VStack {
            
            NumberIndicator(currentIndex: $currentIndex)
                .padding(.top, 60)
            
            VStack(alignment: .leading) {
                Text("오월이에서 사용할\n닉네임을 입력해주세요.")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                Text("닉네임")
                    .foregroundColor(Color.oworiGray500)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                HStack {
                    TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $nickname)
                    // 텍스트가 변경될 때마다 글자 수 확인
                        .onChange(of: nickname) { newText in
                            if newText.count > 7 {
                                nickname = String(newText.prefix(7))
                            }
                        }
                    Text("\(nickname.count)/7")
                }
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                .foregroundColor(.gray)
                
                
                
                // 여기에서 넘긴 value를 어디에 쓸지 잘 모르겠음... 사실 안넘겨도 되는 값이긴 함
                // .navigationDestination()에서 뷰 파라미터에 어차피 값 같이 넘김..
                // 일단 임시방편으로 currentIndex 대신 사용하는 방법 생각해보자..
                NavigationLink(value: 2) {
                    Button {
                        if !nickname.isEmpty {
                            isSecondViewActive = true
                        } else {
                            isSecondViewActive = false
                        }
                    } label: {
                        if !nickname.isEmpty {
                            Text("확인1")
                        } else {
                            Text("확인2")
                        }
                    }
                    .disabled(nickname.isEmpty)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    BackToLoginButton(currentIndex: $currentIndex)
                }
                .navigationDestination(isPresented: $isSecondViewActive) {
                    JoinBirthday(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
                }
            }
            .onAppear {
                currentIndex = 1
            }
        }
    }
}

struct JoinNickname_Previews: PreviewProvider {
    static var previews: some View {
        JoinNickname()
    }
}
