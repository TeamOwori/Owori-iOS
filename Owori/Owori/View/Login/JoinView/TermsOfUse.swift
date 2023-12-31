//
//  TermsOfUse.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct TermsOfUse: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @State private var isJoinFamilyActive = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @State private var checkForService = false
    @State private var checkForUseOfInformation = false
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            VStack {
                Text("오월이가 처음이시죠?\n필수약관에 동의해주세요")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 80, leading: 20, bottom: 20, trailing: 20))
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                HStack {
                    Button {
                        checkForService.toggle()
                    } label: {
                        if checkForService == false {
                            Image("Checked")
                                .resizable()
                                .frame(width: 20, height: 20)
                        } else {
                            Image("Checked1")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.leading,15)
                    Spacer()
                    Button {
                        if let url = URL(string: "https://zeroexn.notion.site/86e355e9c415493695784ca02a3b329e") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("서비스 운영약관 동의 (필수)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.leading,10)
                        Spacer()
                        Image("Right")
                            .frame(width: 20, height: 20)
                            .padding(.trailing,10)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width)
                }
                HStack {
                    Button {
                        checkForUseOfInformation.toggle()
                    } label: {
                        if checkForUseOfInformation == false {
                            Image("Checked")
                                .resizable()
                                .frame(width: 20, height: 20)
                        } else {
                            Image("Checked1")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }.padding(.leading,15)
                    Spacer()
                    Button {
                        if let url = URL(string: "https://zeroexn.notion.site/2abdc0d3fa724b32bc4db75b34eade45") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Text("개인정보 수집 및 이용동의 (필수)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.leading,10)
                        Spacer()
                        Image("Right")
                            .frame(width: 20, height: 20)
                            .padding(.trailing,10)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width)
                }
                Spacer()
                HStack(alignment: .center) {
                    Button {
                        if checkForService && checkForUseOfInformation {
                            if loginViewModel.isLoggedIn {
                                isJoinFamilyActive = true
                            }
                        } else {
                            isJoinFamilyActive = false
                        }
                    } label: {
                        Text("동의하기")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width, height: 52, alignment: .center)
                    }
                    .background(Color.oworiOrange)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isJoinFamilyActive) {
                JoinFamily(isLoggedIn: $isLoggedIn, currentIndex: $currentIndex, nickname: $nickname, birthDateText: $birthDateText, familyName: $familyName, inviteCode: $inviteCode)
            }
            .onAppear {
                currentIndex = 2
            }
        }
    }
}

struct TermsOfUse_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUse(isLoggedIn: .constant(false), currentIndex: .constant(5), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
            .environmentObject(LoginViewModel())
    }
}
