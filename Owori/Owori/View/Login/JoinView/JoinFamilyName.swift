//
//  JoinFamilyName.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinFamilyName: View {
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @State private var isFourthViewActive: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("우리 가족\n그룹명을 정해주세요.")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
            Text("가족 그룹명")
                .foregroundColor(Color.oworiGray500)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            HStack {
                TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $familyName)
                // 텍스트가 변경될 때마다 글자 수 확인
                    .onChange(of: familyName) { newText in
                        if newText.count > 10 {
                            familyName = String(newText.prefix(10))
                        }
                    }
                Text("\(familyName.count)/10")
            }
            .overlay(Rectangle().frame(height: 1).padding(.top, 30))
            .foregroundColor(.gray)
            
            NavigationLink (value: 4) {
                Button {
                    if !familyName.isEmpty {
                        isFourthViewActive = true
                    } else {
                        isFourthViewActive = false
                    }
                } label: {
                    if !birthDateText.isEmpty {
                        Text("확인1")
                    } else {
                        Text("확인2")
                    }
                }
                .disabled(birthDateText.isEmpty)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                BackToLoginButton(currentIndex: $currentIndex)
            }
            .navigationDestination(isPresented: $isFourthViewActive) {
                JoinFamily(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
        }
        .onAppear {
            currentIndex = 3
        }
        
        
    }
}

struct JoinFamilyName_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamilyName(currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
