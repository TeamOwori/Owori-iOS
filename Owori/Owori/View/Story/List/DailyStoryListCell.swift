//
//  DailyStoryListCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryListCell: View {
    @Binding var storyInfo: Story.StoryInfo
    
    var body: some View {
        VStack {
            HStack {
                DailyStoryText(storyTitle: storyInfo.title ?? "Title", storyContent: storyInfo.content ?? "Content")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                Spacer()
                DailyStoryImageCell(storyInfo: $storyInfo)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                    .clipped()
                    .cornerRadius(12)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                Text("좋아요 \(storyInfo.heart_count ?? 0)")
                Text("• \(storyInfo.writer ?? "Unknown")")
                Spacer()
                Text((storyInfo.start_date ?? "nil") + " ~ " + (storyInfo.end_date ?? "nil"))
            }
            .foregroundColor(.gray)
            .font(.subheadline)
        }
    }
}

struct DailyStoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryListCell(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")))
    }
}
