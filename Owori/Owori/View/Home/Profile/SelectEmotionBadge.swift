//
//  SelectEmotionBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct SelectEmotionBadge: View {
    @State private var isEmotion: Bool = false
    
    // 임시 emotionalbadges 데이터 변수
    @State private var emotionalbadges = ["squinting-face-with-tongue", "smirking-face", "smiling-face-with-smiling-eyes", "smiling-face-with-heart-eyes", "sleeping-face", "pouting-face", "neutral-face", "loudly-crying-face", "face-with-open-mouth", "face-screaming-in-fear", "face-blowing-a-kiss", "dizzy-face", "crying-face", "confused-face", "angry-face",
    ]
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @State private var emotionalBadge: String = ""
    
    var body: some View {
//        NavigationStack {
            ZStack {
                Color.oworiMain
                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        VStack {
                            Text("기분 어떤가요?")
                                .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                .foregroundColor(.black)
                            Text("감정뱃지 등록해봐요")
                                .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                                .foregroundColor(Color.oworiGray700)
                        }
                        .padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.005, leading: 0, bottom: 0, trailing: 0)) // .padding(.top, 75)
                        LazyVGrid(columns: columns, spacing: UIScreen.main.bounds.width * 0.1) {
                            ForEach(emotionalbadges[0 ..< emotionalbadges.count], id: \.self) { imageName in
                                Button {
                                    if emotionalBadge == imageName {
                                        // 이미 이미지를 선택한 경우
                                        isEmotion = false
                                        emotionalBadge = ""
                                    } else {
                                        // 이미지를 선택 시
                                        isEmotion = true
                                        emotionalBadge = imageName
                                    }
                                    //print(isEmotion,emotionalBadge)
                                } label: {
                                    ZStack {
                                        Image(imageName)
                                            .frame(width: 60, height: 60)
                                            .background(
                                                Circle()
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.white)
                                            )
                                        if emotionalBadge == imageName {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.oworiOrange)
                                                .frame(width: 40, height: 40)
                                                .background(
                                                    Circle()
                                                        .frame(width: 80, height: 80)
                                                        .foregroundColor(.black.opacity(0.4))
                                                )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 50, leading: 50, bottom: UIScreen.main.bounds.height * 0.05, trailing: 50))
                        
                    }
                    Button {
                        
                    } label: {
                        HStack(alignment: .center, spacing: 10) {
                            Text("확인")
                                .font(Font.custom("Pretendard", size: 20).weight(.bold))
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 10, leading: 78, bottom: 10, trailing: 78))
                        .frame(width: 255, height: 44, alignment: .center)
                        .background(Color.oworiOrange)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.12), radius: 12, x: 4, y: 4)
                        .shadow(color: .black.opacity(0.1), radius: 5.5, x: 2, y: 2)
                    }
                }
            }
//        }
    }
}

struct SelectEmotionBadge_Previews: PreviewProvider {
    static var previews: some View {
        SelectEmotionBadge()
    }
}
