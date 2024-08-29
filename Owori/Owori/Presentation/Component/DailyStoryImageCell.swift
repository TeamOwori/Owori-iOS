//
//  DailyStoryImageCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/03.
//

import SwiftUI

struct DailyStoryImageCell: View {
    @Binding var storyInfo: Story.StoryInfo

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: storyInfo.thumbnail ?? "")) { image in
                image
                    .resizable()
            } placeholder: {
                Image("DefaultImage")
            }
            if storyInfo.story_images?.count ?? 0 > 1 {
                    Image("Layers")
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 8))
            }
        }
        .scaledToFit()
    }
}

struct DailyStoryImageCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryImageCell(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")))
    }
}
