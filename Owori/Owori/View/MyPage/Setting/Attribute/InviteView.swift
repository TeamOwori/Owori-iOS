//
//  InviteView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct InviteView: View {
    
    var body: some View {
        VStack{
            Text("우리 가족 초대해요!")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
            
            Text("가족 구성원들에게 초대코드를 보내서\n오월이를 함께 이용해봐요?")
                .font(.body)
                .foregroundColor(Color.oworiGray400)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
            //Image 넣어야함
            Image("가족초대코드")
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                .aspectRatio(contentMode: .fit)

            Spacer()

            Button {

            } label: {
                Text("초대코드 공유")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.09)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(EdgeInsets(top: 0, leading: 140, bottom: 0, trailing: 140))

            Spacer()

            Text("초대 코드는 발급 후 30분 이내로 입력가능해요")
                .font(
                    Font.custom("Pretendard", size: 15)
                        .weight(.medium)
                )
                .kerning(0.12)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.oworiGray300)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                
                HStack(alignment: .center) {
                    
                    BackButton()
                }
                
            }
        }
    }
}

struct InviteView_Previews: PreviewProvider {
    static var previews: some View {
        InviteView()
    }
}
