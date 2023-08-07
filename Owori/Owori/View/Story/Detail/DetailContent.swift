//
//  DetailContent.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct DetailContent: View {
    
    @Binding var isFavorite: Bool
    var storyInfo: Story.StoryInfo
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ContentTitle(isFavorite: $isFavorite, storyInfo: storyInfo)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
            
            ContentText(storyInfo: storyInfo)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    
            
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
        }
    }
}

struct DetailContent_Previews: PreviewProvider {
    static var previews: some View {
        DetailContent(isFavorite: .constant(true), storyInfo: Story.StoryInfo(id: 0, story_id: "0", is_liked: true, images_id: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
