//
//  OnBoardingView.swift
//  Owori
//
//  Created by 신예진 on 7/10/23.
//

import SwiftUI


struct OnBoardingView: View {
    private var indexOfTitle: Int = 1
    private var titles: [String] = ["우리 가족 소통해요", "가족과 일정을 공유해요", "우리 가족만의 추억을 기록해봐요"]
    @State private var titleIndex: Int = 0
    private var indexOfBody: Int = 1
    private var bodies: [String] = ["‘감정뱃지’로 나의 기분을 표현하고 \n ‘서로에게 한마디’를 나눠봐요", "공유 캘린더로 온가족의 일정을 체크할 수 있어요 중요한 가족행사는 오월이가 알려줄게요", "사진과 함께 그날의 이야기를 공유할 수 있어요 하루하루를 가족과 함께해요"]
    @State private var bodyIndex: Int = 0
    private var indexOfImage: Int = 1
    private var images: [String] = ["작업영역","작업영역 (1)","작업영역 (11)"]
    @State private var imageIndex: Int = 0
    @State private var animationValue: CGFloat = 0
    @State var offset: CGFloat = 0
    @State private var isLoginViewVisible: Bool = false
    
    var body: some View{
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    TabView(selection: $titleIndex) {
                        ForEach(0 ..< titles.count, id: \.self) { index in
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(titles[index])
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.black)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    .tag(0)
                                Text(bodies[index])
                                    .font(.title3)
                                    .foregroundColor(Color.gray)
                                    .padding(EdgeInsets(top: 3, leading: 20, bottom: 0, trailing: 0))
                                    .tag(1)
                                Image(images[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width,height:UIScreen.main.bounds.height*0.5)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .background(.white)
                                    .tag(2)
                                Spacer()
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .edgesIgnoringSafeArea(.top)
                }
                Spacer()
                Button{
                    if titleIndex >= 2 {
                        isLoginViewVisible = true
                    } else {
                        titleIndex = titleIndex + 1
                    }
                } label: {
                    if titleIndex < 2 {
                        Text("다음")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width, height: 52)
                            .background(Color.oworiOrange)
                    } else {
                        Text("로그인하기")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width, height: 52)
                            .background(Color.oworiOrange)
                    }
                }
            }
            .navigationDestination(isPresented: $isLoginViewVisible) {
                LoginView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
