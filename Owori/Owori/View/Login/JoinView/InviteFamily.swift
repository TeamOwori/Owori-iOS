//
//  InviteFamliy.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI
import SimpleToast

struct InviteFamily: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    //    @Binding var isFifthViewVisible: Bool
    // 임시로 true로 변경. 기본값 = false
    
    @State var showToast: Bool = false
    @State private var isSuccessSignUp: Bool = false
    @State private var oworiInstagramURL: String = "https://www.instagram.com/owori_official/"
    
    private let toastOptions = SimpleToastOptions(
        hideAfter: 2
    )
    
    @State private var isShareSheetPresented = false
        let myURL = URL(string: "https://www.google.com")!
    
    var body: some View {
        VStack {
            Text("가족그룹을 만들었어요.")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
            
            Text("가족을 초대해볼까요?")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
            //Image 넣어야함
            ZStack {
                Image("가족초대코드")
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                    .padding(EdgeInsets(top: -30, leading: 30, bottom: 0, trailing: 30))
                    .aspectRatio(contentMode: .fit)
                Text("\(familyViewModel.family.invite_code ?? "error")")
                    .offset(x: -30, y: 15)
            }
            
            
            Spacer()
            
            
            Button{
//                isShareSheetPresented.toggle()
            } label: {
                ShareLink(
                    item: "",
                    message: Text("\(familyViewModel.family.invite_code ?? "errer")"),
                    preview: SharePreview(
                        Text("오월이 가족 초대코드"),
                        image: Image("오월이")
                    )
                ) {
                    Label("초대코드 공유", systemImage: "")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.05)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
            
            Text("초대 코드는 발급 후 30분 이내로 입력가능해요\n입력 시간을 놓치셨더라도 걱정마세요!\n[설정] - [초대하기]를 통해")
                .font(
                    Font.custom("Pretendard", size: 15)
                        .weight(.medium)
                )
                .kerning(0.12)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.oworiGray300)
                .frame(width: UIScreen.main.bounds.width*0.8)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Text("초대코드 발급이 가능해요")
                .font(
                    Font.custom("Pretendard", size: 15)
                        .weight(.medium)
                )
                .kerning(0.12)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.oworiGray300)
                .frame(width: UIScreen.main.bounds.width*0.8)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 50, trailing: 20))
            
            Spacer()
            
            
            HStack(alignment: .center) {
                Button {
                    isSuccessSignUp = true
                    //                    isCreateCodeViewVisible = false
                    //                    isReceiveCodeViewVisible = false
                    
                    if loginViewModel.isLoggedIn {
                        // 로그 확인
                        print(nickname)
                        print(birthDateText.convertToISODateFormat())
                        
                        
                        if userViewModel.user.is_service_member ?? false {
                            familyViewModel.lookUpHomeView(user: userViewModel.user) {
                                print(familyViewModel.getFamily())
                                userViewModel.lookupProfile() {
                                    isSuccessSignUp = true
                                    
                                    
                                }
                            }
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
        }
//        .sheet(isPresented: $isShareSheetPresented) {
//            ShareLink(
//                item: myURL,
//                subject: Text("Subject"),
//                message: Text("링크첨부"),
//                preview: SharePreview(
//                    Text("오월이가 공유하고 싶은 것"),
//                    image: Image("오월이")
//                )
//            )
//        }
        .navigationDestination(isPresented: $isSuccessSignUp) {
            MainView(isLoggedIn: $isLoggedIn)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            currentIndex = 4
        }
    }
}

struct InviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        InviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
            .environmentObject(LoginViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
