//
//  InviteView.swift
//  Owori
//
//  Created by 신예진 on 2023/07/20.
//

import SwiftUI
import SimpleToast

struct InviteView: View {
    
    @State var showToast: Bool = false
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    private let toastOptions = SimpleToastOptions(
        hideAfter: 0.8
    )
    
    var body: some View {
        VStack{
            VStack(alignment:.center,spacing: 5){
                
                Text("우리 가족 초대해요!")
                    .font(.title)
                    .bold()
                
                Text("가족 구성원들에게 초대코드를 보내서")
                    .font(.body)
                    .foregroundColor(Color.oworiGray400)
                
                Text("오월이를 함께 이용해봐요?")
                    .font(.body)
                    .foregroundColor(Color.oworiGray400)
                   
            }
            .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))

    
            ZStack {
                
                //Image 넣어야함
                Image("가족초대코드")
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .aspectRatio(contentMode: .fit)
                
                Text("\(familyViewModel.family.invite_code ?? "error")")
                    .offset(x: -30, y: 30)
            }
                

            Button {
                withAnimation {
                    showToast.toggle()
                }
            } label: {
                Text("초대코드 공유")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.05)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding(.top,-50)
            .simpleToast(isPresented: $showToast, options: toastOptions) {
                Text("초대코드가 복사되었어요")
                    .font(
                    Font.custom("Pretendard", size: 12)
                    .weight(.medium)
                    )
                    .kerning(0.12)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 6, leading: 11, bottom: 6, trailing: 11))
                .background(.black.opacity(0.78))
                .foregroundColor(Color.white)
                .cornerRadius(8)
                .offset(y: UIScreen.main.bounds.height * 0.245)
                
            }
           
           
            Spacer()

            Text("초대 코드는 발급 후 30분 이내로 입력가능해요")
                .font(
                    Font.custom("Pretendard", size: 15)
                        .weight(.medium)
                )
                .kerning(0.12)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.oworiGray300)
                .padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))

            Spacer()
        }
        .onAppear {
            familyViewModel.regenInvitecode(user: userViewModel.user)
        }
//        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                    BackButton()
//            }
//        }
    }
}

struct InviteView_Previews: PreviewProvider {
    static var previews: some View {
        InviteView()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}

