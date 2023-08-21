//
//  DailyStoryListCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryListCell: View {
    // MARK: PROPERTIES
//    /// - [임시] 좋아요 수 데이터
//    /// - 실제 이미지가 들어오면 없어질 예정
//    private var numberOfFavorite: Int = 4
//
//    /// - [임시] 댓글 수 데이터
//    /// - 실제 이미지가 들어오면 없어질 예정
//    private var numberOfcomment: Int = 2
//
//    /// - [임시] 작성자 데이터
//    /// - 실제 이미지가 들어오면 없어질 예정
//    private var author: String = "쥐렁이"
    
    @Binding var storyInfo: Story.StoryInfo
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                DailyStoryText(storyTitle: storyInfo.title ?? "Title", storyContent: storyInfo.content ?? "Content")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                Spacer()
                DailyStoryImageCell(storyInfo: $storyInfo)
                // ImageCell 크기 처리하는 부분 PM이랑 상의해보기(태블릿 대응)
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            HStack {
                Text("좋아요 \(storyInfo.heart_count ?? 0)")
//                Text("댓글 \(storyInfo.comment_count ?? 0)")
                Text("• \(storyInfo.writer ?? "Unknown")")
                Spacer()
                // Test용 데이터
                Text((storyInfo.start_date ?? "nil") + " ~ " + (storyInfo.end_date ?? "nil"))
            }
            .foregroundColor(.gray)
            .font(.subheadline)
        }
    }
}


// MARK: PREVIEWS
struct DailyStoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryListCell(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")))
    }
}
