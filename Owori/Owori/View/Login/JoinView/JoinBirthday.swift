//
//  JoinBirthday.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinBirthday: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    
    
    @State private var previousBirthDateText: String = ""
    @State private var isThirdViewActive: Bool = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            VStack(alignment: .leading) {
                Text("생년월일 8자리를 입력해주세요")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 20))
                
                Text("원활한 서비스를 위해 생년월일이 필요해요\n매년 오월이가 생일을 챙겨줄게요!")
                    .foregroundColor(Color.oworiGray500)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
                
                HStack {
                    Text("생년월일  ")
                    TextField("YYYYMMDD", text: $birthDateText)
                        .keyboardType(.numberPad)
                        .onChange(of: birthDateText) { newValue in
                            // 사용자가 입력한 값을 변환하는 로직을 구현
                            
                            if newValue.count > 8 {
                                birthDateText = String(newValue.prefix(8))
                            }
                        }
                }
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                .padding(.leading,20)
                .padding(.trailing,20)
                .foregroundColor(.gray)
                
                if birthDateText.count < 8 {
                    Text("생년월일을 8자리에 맞게 입력해 주세요.\n제대로 입력하지 않으면, 회원가입이 불가능할 수도 있습니다.")
                        .foregroundColor(.red)
                        .padding(.leading, 20)
                } else {
                    Text("올바르게 입력했어요")
                        .foregroundColor(.blue)
                        .padding(.leading, 20)
                }
                
                
                Spacer()
                
                Button{
                    if birthDateText.count >= 8 {
                        isThirdViewActive = true
                    } else {
                        isThirdViewActive = false
                    }
                } label: {
                    Text("확인")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 52)
                }
                .background(Color.oworiOrange)
                .disabled(birthDateText.isEmpty)
                
//                Button {
//
//                } label: {
//                    if !birthDateText.isEmpty {
////                        Text("확인1")
//                    } else {
////                        Text("확인2")
//                    }
//                }

            }
            .onAppear {
                currentIndex = 2
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isThirdViewActive) {
            TermsOfUse(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
        }
    }
}


struct JoinBirthday_Previews: PreviewProvider {
    static var previews: some View {
        JoinBirthday(isLoggedIn: .constant(false), currentIndex: .constant(2), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
