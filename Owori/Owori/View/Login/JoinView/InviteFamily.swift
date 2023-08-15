//
//  InviteFamliy.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI
import SimpleToast

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
    
    @State var showToast: Bool = false
    
    private let toastOptions = SimpleToastOptions(
        hideAfter: 2
    )
    
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
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                .padding(EdgeInsets(top: -30, leading: 30, bottom: 0, trailing: 30))
                .aspectRatio(contentMode: .fit)

            Spacer()

            Button {
                withAnimation{
                    showToast.toggle()
                }
            } label: {
                Text("초대코드 공유")
                    .bold()
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .frame(width: UIScreen.main.bounds.width * 0.4 , height: UIScreen.main.bounds.height * 0.07)
                    .background(Color.blue)
                    .cornerRadius(8)
            }.simpleToast(isPresented: $showToast, options: toastOptions) {
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
                .offset(y: UIScreen.main.bounds.height * 0.15)
            }

            Spacer()

            Text("초대 코드는 발급 후 30분 이내로 입력가능해요\n입력 시간을 놓치셨더라도 걱정마세요!\n[설정] - [맞춤설정] - [초대하기]를 통해")
                .font(
                    Font.custom("Pretendard", size: 15)
                        .weight(.medium)
                )
                .kerning(0.12)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.oworiGray300)
                .frame(width: UIScreen.main.bounds.width*0.8)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Text("초대코드 발급 가능해요")
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    BackToFamilyLinkViewButton(isCreateCodeViewVisible: $isCreateCodeViewVisible, isReceiveCodeViewVisible: $isReceiveCodeViewVisible)
                }
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
