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
    
    @State private var isSuccessSignUp = false
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    //CheckBox 코드
    @State private var checkForService = false
    
    //CheckBox 코드
    @State private var checkForUseOfInformation = false
    
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .offset(y: 0)
            
            VStack{
                Text("오월이가 처음이시죠?\n필수약관에 동의해주세요")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        
                        Button {
                            checkForService.toggle()
                        } label: {
                            if checkForService == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        Text("서비스 운영약관 동의 (필수)")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Button {
                            //서비스 운영약관 동의 링크가 뜨게 해야함.
                            if let url = URL(string: "https://zeroexn.notion.site/86e355e9c415493695784ca02a3b329e") {
                                UIApplication.shared.open(url)
                            }
                            
                        } label: {
                            Image("약관버튼")
                                .frame(width: 30, height: 30)
                        }
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                        
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .padding(.leading, 50)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        
                        Button {
                            checkForUseOfInformation.toggle()
                        } label: {
                            if checkForUseOfInformation == false {
                                Image("Checked")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            } else {
                                Image("Checked1")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        Text("개인정보 수집 및 이용동의 (필수)")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Button {
                            //개인정보 수집 및 이용동의 뜨게 해야함
                            if let url = URL(string: "https://zeroexn.notion.site/2abdc0d3fa724b32bc4db75b34eade45") {
                                UIApplication.shared.open(url)
                            }
                            
                        } label: {
                            Image("약관버튼")
                                .frame(width: 30, height: 30)
                            
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0))
                        
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
                .padding(.leading, 50)
                
                
                
                Spacer()
                
                HStack(alignment: .center) {
                    Button {
                        if checkForService && checkForUseOfInformation {
                            if loginViewModel.isLoggedIn {
                                userViewModel.initUser(userInfo: [
                                    "nickname" : "\(nickname)",
                                    "birthday" : "\(birthDateText)"])
                                familyViewModel.addFamilyMember(user: userViewModel.user, family_group_name: familyName)
                                print(familyName)
                                print(userViewModel.user)
                                print(familyViewModel.family)
                                
                                isSuccessSignUp = true
                            }
                        } else {
                            isSuccessSignUp = false
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
            .navigationDestination(isPresented: $isSuccessSignUp) {
                MainView()
            }
            .onAppear {
                currentIndex = 5
            }
        }
    }
    
    struct TermsOfUse_Previews: PreviewProvider {
        static var previews: some View {
            TermsOfUse(isLoggedIn: .constant(false), currentIndex: .constant(5), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
        }
    }
}
