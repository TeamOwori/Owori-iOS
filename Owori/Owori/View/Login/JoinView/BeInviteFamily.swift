//
//  BeInviteFamily.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct BeInviteFamily: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @Binding var isCreateCodeViewVisible: Bool
    @Binding var isReceiveCodeViewVisible: Bool
    @State private var isSuccessSignUp: Bool = false
    @State private var isUserInitFail: Bool = false
    @State private var isInvalidInvitationCode: Bool = false
    // 임시로 true로 변경. 기본값 = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            VStack(alignment: .leading) {
                
                Text("초대코드를 입력해주세요")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 100, leading: 20, bottom: 0, trailing: 20))
                
                Text("가족에게 초대코드를 받으셨나요?").foregroundColor(Color.oworiGray500)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 0))
                
                HStack {
                    Text("초대코드")
                    
                    Image("초대코드입력")
                        .frame(width: 1, height: 21)
                    
                    TextField("", text: $inviteCode)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                        .foregroundColor(.gray)
                        .onChange(of: inviteCode) { newText in
                            if newText.count > 10 {
                                inviteCode = String(newText.prefix(10))
                            }
                        }
                }
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                .padding(.leading,20)
                .padding(.trailing,20)
                .foregroundColor(.gray)
                
                if inviteCode.count < 10 {
                    Text("열 글자의 초대 코드를 입력해주세요.")
                        .foregroundColor(.red)
                        .padding(.leading, 20)
                }
//                else {
//                    Text("올바른 초대 코드입니다. 환영합니다!")
//                        .foregroundColor(.blue)
//                        .padding(.leading, 20)
//                }
                
                Spacer()
                
                
                HStack(alignment: .center) {
                    Button {
                        userViewModel.initUser(userInfo: ["nickname" : "\(nickname)", "birthday" : "\(birthDateText)"]) { success in
                            isUserInitFail = !success
                            if success {
                                familyViewModel.addFamilyMemberInviteCode(user: userViewModel.user, invite_code: inviteCode) { addFamilyMemberInviteCodeSuccess in
                                    if addFamilyMemberInviteCodeSuccess {
                                        if userViewModel.user.is_service_member ?? false {
                                            familyViewModel.lookUpHomeView(user: userViewModel.user) {
                                                print(familyViewModel.getFamily())
                                                userViewModel.lookupProfile() {
                                                    isUserInitFail = false
                                                    isSuccessSignUp = true
                                                    isInvalidInvitationCode = false
                                                }
                                            }
                                        }
                                    } else {
                                        isInvalidInvitationCode = true
                                    }
                                    
                                }
                            } else {
                                isUserInitFail = true
                            }
                        }
                    } label: {
                        Text("다음")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width, height: 52, alignment: .center)
                        
                    }
                    .background(Color.oworiOrange)
                }
                
                //                Button {
                //                    if inviteCode == "testInvite" {
                //                        isFifthViewVisible = true
                //                        isCreateCodeViewVisible = false
                //                        isReceiveCodeViewVisible = false
                //                    } else {
                //                        isFifthViewVisible = false
                //                    }
                //                } label: {
                //                    Text("testInvite")
                //                }
                
            }
        }
        .alert(isPresented: $isUserInitFail) {
            Alert(
                title: Text("알림"), message: Text("잘못 입력된 정보가 있습니다.\n다시 입력해 주세요."),
                dismissButton: .default(Text("확인"))
                )
        }
        .alert(isPresented: $isInvalidInvitationCode) {
            Alert(
                title: Text("알림"), message: Text("초대코드가 유효하지 않습니다.\n다시 입력해 주세요."),
                dismissButton: .default(Text("확인"))
                )
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .navigationBarTitleDisplayMode(.inline)
        //        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isSuccessSignUp) {
            MainView(isLoggedIn: $isLoggedIn)
        }
        //        .toolbar {
        //            BackToFamilyLinkViewButton(isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isReceiveCodeViewVisible)
        //        }
        .onAppear {
            currentIndex = 5
        }
    }
}

struct BeInviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        BeInviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(4), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""), isCreateCodeViewVisible: .constant(false), isReceiveCodeViewVisible: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
