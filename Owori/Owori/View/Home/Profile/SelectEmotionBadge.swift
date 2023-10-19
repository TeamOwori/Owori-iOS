//
//  SelectEmotionBadge.swift
//  Owori
//
//  Created by 희 on 2023/07/23.
//

import SwiftUI

struct SelectEmotionBadge: View {
    @State private var isEmotion: Bool = false
    @State private var emotionalbadges = ["JOY", "HAPPY", "SO_HAPPY", "LOVE", "SURPRISED", "INSIDIOUS", "NORMAL", "SLEEPY", "FAINT", "SULKY", "SAD", "CRY", "GOOSE_BUMPS", "ANGRY", "VERY_ANGRY"]
    @Binding var emotionalBadgeViewIsActive: Bool
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @State private var emotionalBadge: String = "NONE"
    
    var body: some View {
        ZStack {
            Color.oworiMain
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("기분 어떤가요?")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.bottom, 3)
                    Text("감정뱃지 등록해봐요")
                        .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                        .foregroundColor(Color.oworiGray700)
                }
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                LazyVGrid(columns: columns) {
                    ForEach(emotionalbadges[0 ..< emotionalbadges.count], id: \.self) { imageName in
                        Button {
                            if emotionalBadge == imageName {
                                isEmotion = false
                                emotionalBadge = "NONE"
                            } else {
                                isEmotion = true
                                emotionalBadge = imageName
                            }
                        } label: {
                            ZStack {
                                Image(imageName)
                                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                    .background(
                                        Circle()
                                            .foregroundColor(.white)
                                    )
                                if emotionalBadge == imageName {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color.oworiOrange)
                                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        .background(
                                            Circle()
                                                .foregroundColor(.black.opacity(0.4))
                                                .frame(width: 80, height: 80)
                                        )
                                }
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 30, bottom: UIScreen.main.bounds.height*0.03, trailing: 30))
                Spacer()
                Button {
                    userViewModel.updateEmotionalBadge(body: ["emotional_badge": emotionalBadge]) {
                        emotionalBadgeViewIsActive = false
                    }
                } label: {
                    Text("확인")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width*0.6,height: UIScreen.main.bounds.height*0.05, alignment: .center)
                }
                .background(Color.oworiOrange)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.12), radius: 12, x: 4, y: 4)
                .shadow(color: .black.opacity(0.1), radius: 5.5, x: 2, y: 2)
                .padding(.bottom, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    emotionalBadgeViewIsActive = false
                } label: {
                    Text("X")
                }
            }
        }
    }
}

struct SelectEmotionBadge_Previews: PreviewProvider {
    static var previews: some View {
        SelectEmotionBadge(emotionalBadgeViewIsActive: .constant(true))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
