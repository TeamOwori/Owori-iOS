//
//  ContentTitle.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import SwiftUI

struct ContentTitle: View {
    @Binding var isFavorite: Bool
    @Binding var storyInfo: Story.StoryInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text((storyInfo.start_date ?? "nil") + " - " + (storyInfo.end_date ?? "nil"))
                    .foregroundColor(Color.oworiGray600)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                FavoriteButton(isFavorite: $isFavorite, storyInfo: $storyInfo)
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
        .onAppear {
            isFavorite = storyInfo.is_liked ?? false
        }
    }
}

struct ContentTitle_Previews: PreviewProvider {
    static var previews: some View {
        ContentTitle(isFavorite: .constant(true), storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "20230707", end_date: "20230708")))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
