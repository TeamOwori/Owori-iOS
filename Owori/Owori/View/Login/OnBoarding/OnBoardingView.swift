//
//  OnBoardingView.swift
//  Owori
//
//  Created by 신예진 on 7/10/23.
//

import SwiftUI


struct OnBoardingView: View {
    
    //    // MARK: PROPERITES
    //
    //    //프로퍼티 지정ㅇ -> TitleName필요, BodyName필요
    //    //폰트컬러,버튼컬러 다 필요
    //    //이미지 받을 배열
    //    //페이지 탭 뷰 -> for each
    //
    //    let TitleName: String
    //    let BodyName: String
    //    let fontColor: Color
    //    let buttonColor: Color
    //
    
    
    
    //title index
    private var indexOfTitle: Int = 1
    private var titles: [String] = ["가족끼리 추억을 기록해봐요", "오늘 기분을 공유해요", "그럼 가족을 등록해볼까요?"]
    @State private var titleIndex: Int = 0
    
    //body index
    private var indexOfBody: Int = 1
    private var bodies: [String] = ["우리 가족의 소중한 추억을 공유할 수 있어요 하루하루를 가족과 함께해요", "가족들에게 현재 나의 기분을 감정뱃지로 표현해봐요 프로필에서 빠르게 확인가능해요", "오월이와 함께 가족방을 만들어봐요!"]
    @State private var bodyIndex: Int = 0
    
    
    //Image index
    private var indexOfImage: Int = 1
    private var images: [String] = ["TestImage1","TestImage2","TestImage3"]
    @State private var imageIndex: Int = 0
    
    var body: some View{
        
        VStack {
            
            //Zstack안에 텍스트, 이미지 다 넣고 탭뷰 스타일 넣어서
            ZStack(alignment: .bottomTrailing) {
                TabView(selection: $titleIndex) {
                    ForEach(0 ..< titles.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(titles[index])
                                .font(.title)
                                .bold()
                            Text(bodies[index])
                                .font(
                                    Font.custom("Pretendard", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.56))
                                .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .topLeading)
                            Image(images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                            
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        
        HStack(alignment: .center, spacing: 0) {
            
            Button(action: {
                // 로그인 버튼 클릭 시 실행될 액션
            }) {
                Text("로그인 하기")
                    .font(
                        Font.custom("Pretendard", size: 20)
                            .weight(.bold)
                    )
                    .foregroundColor(.white)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 52)
        .background(Color(red: 0.98, green: 0.48, blue: 0.33))
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
