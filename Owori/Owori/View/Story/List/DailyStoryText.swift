//
//  DailyStoryText.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryText: View {
    // MARK: PROPERTIES
//    /// - [임시] 제목 데이터
//    /// - 실제 이미지가 들어오면 없어질 예정
//    private var titleText: String = "기다리고 기다리던 하루"
//
//    /// - [임시] 제목 데이터
//    /// - 실제 이미지가 들어오면 없어질 예정
//    private var contentText: String = "종강하면 동해바다로 가족여행 가자고 한게 엊그제같았는데...3박 4일 동해여행 너무 재밌었어!! 날시도 너무 좋았고 특히 갈치조림이 대박👍🏻 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ"
    
    var storyTitle: String
    var storyContent: String

    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text(storyTitle)
                .font(.title3)
                .bold()
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .lineLimit(1)
            Text(storyContent)
                .font(.body)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .lineLimit(2)
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
            .font(.footnote)
            
        }
    }
}

// MARK: PREVIEWS
struct DailyStoryText_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryText(storyTitle: "TEST", storyContent: "TEST")
    }
}
