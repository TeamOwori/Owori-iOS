//
//  InviteFamliy.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct InviteFamily: View {
    @Binding var isLoggedIn: Bool
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    @Binding var isCreateCodeViewVisible: Bool
    @Binding var isReceiveCodeViewVisible: Bool
    @Binding var isFifthViewVisible: Bool
    // 임시로 true로 변경. 기본값 = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text("가족그룹을 만들었어요.")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
            Text("가족을 초대해볼까요?")
                .font(.title)
                .bold()
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
            //계속 오류떠서 주석처리 해버림.
            //                Button {
            //                    ShareLink(
            //                        item: URL(string: "https://developer.apple.com/xcode/swiftui/")!,
            //                        preview: SharePreview(
            //                            "SwiftUI",
            //                            image: Image("SwiftUI")
            //                        )
            //                    )
            //                } label: {
            ////                    Text("초대코드 공유")
            //                }
            
            //Image 넣어야함
            Image("가족초대코드")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                .aspectRatio(contentMode: .fill)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("초대코드 공유")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.5 , height: UIScreen.main.bounds.height * 0.15)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(EdgeInsets(top: 0, leading: 140, bottom: 0, trailing: 140))
            
            Spacer()
            
            Text("초대 코드는 발급 후 30분 이내로 입력가능해요\n입력 시간을 놓치셨더라도 걱정마세요!\n[설정] - [맞춤설정] - [초대하기]를 통해\n초대코드 발급 가능해요")
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

            
            HStack(alignment: .center) {
                Button {
                    isFifthViewVisible = true
                    isCreateCodeViewVisible = false
                    isReceiveCodeViewVisible = false
                } label: {
                    Text("다음")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 52, alignment: .center)
                    
                }
                .background(Color.oworiOrange)
            }
            //                .padding(.trailing, 0 )
            
            
            //                Button {
            //                    isFifthViewVisible = true
            //                    isCreateCodeViewVisible = false
            //                    isReceiveCodeViewVisible = false
            //                } label: {
            ////                    Text("임시 확인")
            //                }
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
        InviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""), isCreateCodeViewVisible: .constant(false), isReceiveCodeViewVisible: .constant(false), isFifthViewVisible: .constant(false))
    }
}
