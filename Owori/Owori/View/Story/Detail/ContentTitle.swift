//
//  ContentTitle.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import SwiftUI

struct ContentTitle: View {
    @Binding var isFavorite: Bool
    var storyInfo: Story.StoryInfo
//    var titleText: String = "기다리고 기다리던 하루"
//
//    /// - [임시] 작성자 데이터
//    /// - 실제 이미지가 들어오면 없어질 예정
//    var author: String = "쥐렁이"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text((storyInfo.start_date ?? "nil") + " - " + (storyInfo.end_date ?? "nil"))
                    .foregroundColor(Color.oworiGray600)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                FavoriteButton(isFavorite: $isFavorite)
            }
            HStack(alignment: .bottom, spacing: 16) {
                Text(storyInfo.title ?? "nil")
                    .foregroundColor(Color.oworiGray700)
                    .font(.system(size: 20, weight: .bold))
                Text("by \(storyInfo.writer ?? "nil")")
                    .foregroundColor(Color.oworiGray700)
                    .font(.system(size: 12, weight: .regular))
            }
        }
    }
}

struct ContentTitle_Previews: PreviewProvider {
    static var previews: some View {
        ContentTitle(isFavorite: .constant(true), storyInfo: Story.StoryInfo(id: 0, story_id: "0", is_liked: true, images_id: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
