//
//  JoinBirthday.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinBirthday: View {
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    
    @State private var isThirdViewActive: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("생년월일 8자리를 입력해주세요")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))
            
            Text("원활한 서비스를 위해 생년월일이 필요해요\n매년 오월이가 생일을 챙겨줄게요!")
                .foregroundColor(Color.oworiGray500)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
            
            HStack {
                Text("생년월일  ")
                TextField("yyyy-mm-dd", text: $birthDateText)
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
            
            Spacer()
            
            Button{
                
            } label: {
                Text("확인")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(width: UIScreen.main.bounds.width, height: 52)
            .background(Color.oworiOrange)
            
            NavigationLink (value: 3) {
                Button {
                    if birthDateText.count >= 8 {
                        isThirdViewActive = true
                    } else {
                        isThirdViewActive = false
                    }
                } label: {
                    if !birthDateText.isEmpty {
                        
                    } else {
                       
                    }
                }
                .disabled(birthDateText.isEmpty)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                BackToLoginButton(currentIndex: $currentIndex)
            }
            .navigationDestination(isPresented: $isThirdViewActive) {
                JoinFamilyName(currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, previousBirthDateText: $previousBirthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
        }
        .onAppear {
                currentIndex = 2
        }
        
    }
    
}


struct JoinBirthday_Previews: PreviewProvider {
    static var previews: some View {
        JoinBirthday(currentIndex: .constant(2), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
