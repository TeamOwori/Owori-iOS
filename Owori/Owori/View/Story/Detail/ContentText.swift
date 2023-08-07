//
//  ContentText.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import SwiftUI

struct ContentText: View {
    //    // MARK: PROPERTIES
    //    /// - [임시] 좋아요 수 데이터
    //    /// - 실제 이미지가 들어오면 없어질 예정
    //    var numberOfFavorite: Int = 4
    //
    //    /// - [임시] 댓글 수 데이터
    //    /// - 실제 이미지가 들어오면 없어질 예정
    //    var numberOfcomment: Int = 2
    //
    //    var contentText: String = "종강하면 동해바다로 가족여행 가자고 한게 엊그제같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박👍🏻 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ"
    
    var storyInfo: Story.StoryInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Text font 스타일 Extension으로 빼서 정리하기
            Text(storyInfo.content ?? "nil")
                .font(.system(size: 16, weight: .medium))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
//                .kerning(1)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            HStack {
                Text("좋아요 \(storyInfo.heart_count ?? 0)")
                    .foregroundColor(Color.oworiGray400)
                    .font(.system(size: 12, weight: .regular))
                Text("댓글 \(storyInfo.comment_count ?? 0)")
                    .foregroundColor(Color.oworiGray400)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                Button {
                    
                } label: {
                    Text("삭제하기")
                        .foregroundColor(Color.oworiGray400)
                        .font(.system(size: 12, weight: .regular))
                }
                Divider()
                    .frame(width: 1, height: 10)
                    .overlay(Color.oworiGray200)
                Button {
                    
                } label: {
                    Text("수정하기")
                        .foregroundColor(Color.oworiGray400)
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
    }
}

struct ContentText_Previews: PreviewProvider {
    static var previews: some View {
        ContentText(storyInfo: Story.StoryInfo(id: 0, story_id: "0", is_liked: true, images_id: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
