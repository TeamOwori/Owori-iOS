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
        VStack {
            
            VStack(alignment: .leading) {
                Text("가족그룹을 만들었어요.\n가족을 초대해볼까요?")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 100, leading: 20, bottom: 20, trailing: 20))
                
                Button {
                    ShareLink(
                        item: URL(string: "https://developer.apple.com/xcode/swiftui/")!,
                        preview: SharePreview(
                            "SwiftUI",
                            image: Image("SwiftUI")
                        )
                    )
                } label: {
//                    Text("초대코드 공유")
                }
                
                //
                
                Spacer()
                
                //Image 넣어야함
                
                
                HStack(alignment: .center, spacing: 10) {
                    Button(action: {
                     
                    }) {
                        Text("초대코드 공유")
                            .bold()
                            .foregroundColor(Color.white)
                            
                    }
                    
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height*0.07, alignment: .center)
                .cornerRadius(12)
                .background(Color(red: 0.11, green: 0.52, blue: 1))
                .cornerRadius(8)
                .padding(EdgeInsets(top: 30, leading: 100, bottom: 50, trailing: 100))
                
                // Body/Body01/Body06
                Text("초대 코드는 발급 후 30분 이내로 입력가능해요\n입력 시간을 놓치셨더라도 걱정마세요!\n[설정] - [맞춤설정] - [초대하기]를 통해\n초대코드 발급 가능해요")
                  .font(
                    Font.custom("Pretendard", size: 12)
                      .weight(.medium)
                  )
                  .kerning(0.12)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.oworiGray300)
                  .frame(maxWidth: .infinity, alignment: .top)
                     
                
                Spacer()
                
                Button{
                    isFifthViewVisible = true
                    isCreateCodeViewVisible = false
                    isReceiveCodeViewVisible = false
                } label: {
                    Text("확인")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width, height: 52)
                .background(Color.oworiOrange)
                
                
//                Button {
//                    isFifthViewVisible = true
//                    isCreateCodeViewVisible = false
//                    isReceiveCodeViewVisible = false
//                } label: {
////                    Text("임시 확인")
//                }
            }
            .onAppear {
                currentIndex = 4
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            BackToFamilyLinkViewButton(isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isCreateCodeViewVisible)
        }
    }
}

struct InviteFamily_Previews: PreviewProvider {
    static var previews: some View {
        InviteFamily(isLoggedIn: .constant(false), currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""), isCreateCodeViewVisible: .constant(false), isReceiveCodeViewVisible: .constant(false), isFifthViewVisible: .constant(false))
    }
}
