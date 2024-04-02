//
//  JoinFamilyName.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct JoinFamilyName: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @State private var isInviteFamilyActive: Bool = false
    @State private var isUserInitFail: Bool = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            VStack(alignment: .leading) {
                Text("우리 가족\n그룹명을 정해주세요.")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 0))
                Text("가족 그룹명")
                    .foregroundColor(Color.oworiGray500)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
                HStack {
                    TextField("숫자, 특수문자, 이모티콘 모두 사용 가능", text: $familyName)
                        .onChange(of: familyName) { newText in
                            if newText.count > 10 {
                                familyName = String(newText.prefix(10))
                            }
                        }
                    Text("\(familyName.count)/10")
                }
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                .padding(.leading,20)
                .padding(.trailing,20)
                .foregroundColor(.gray)
                if familyName.isEmpty {
                    Text("한 글자 이상 입력해 주세요.")
                        .foregroundColor(.red)
                        .padding(.leading, 20)
                }
                Spacer()
                Button {
                    if !familyName.isEmpty {
                        userViewModel.initUser(userInfo: ["nickname" : "\(nickname)", "birthday" : "11111111"]) { success in
                            isUserInitFail = !success
                            print("isUserInitFail : \(isUserInitFail)")
                            if success {
                                familyViewModel.createFamily(user: userViewModel.user, family_group_name: familyName) {
                                    print("isInviteFamilyActive : \(isInviteFamilyActive)")
                                    isUserInitFail = false
                                    isInviteFamilyActive = true
                                }
                            } else {
                                isUserInitFail = true
                            }
                        }
                    } else {
                        isInviteFamilyActive = false
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
                .alert(isPresented: $isUserInitFail) {
                    Alert(
                        title: Text("알림"), message: Text("잘못 입력된 정보가 있습니다.\n다시 입력해 주세요."),
                        dismissButton: .default(Text("확인"))
                    )
                }
            }
            .onAppear {
                currentIndex = 4
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isInviteFamilyActive) {
            InviteFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
        }
    }
}

struct JoinFamilyName_Previews: PreviewProvider {
    static var previews: some View {
        JoinFamilyName(isLoggedIn: .constant(false), currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
