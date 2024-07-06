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
    @State private var oworiInstagramURL: String = "https://www.instagram.com/owori_official/"
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    private let toastOptions = SimpleToastOptions(
        hideAfter: 0.8
    )
    
    var body: some View {
        VStack {
            VStack(alignment:.center,spacing: 5) {
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
                Image("가족초대코드")
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .aspectRatio(contentMode: .fit)
                
                Text("\(familyViewModel.family.invite_code ?? "서버 에러입니다.\n나중에 다시 시도해주세요.")")
                    .offset(x: -30, y: 30)
            }
            Button {

            } label: {
                ShareLink(
                    item: "",
                    subject: Text(""),
                    message: Text("<오월이 가족 초대코드>\n초대코드 : \(familyViewModel.family.invite_code ?? "errer")"),
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
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InviteView_Previews: PreviewProvider {
    static var previews: some View {
        InviteView()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}

