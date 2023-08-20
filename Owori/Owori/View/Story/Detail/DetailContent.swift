//
//  DetailContent.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct DetailContent: View {
    
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    @Binding var isFavorite: Bool
    @Binding var storyInfo: Story.StoryInfo
    
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ContentTitle(isFavorite: $isFavorite, storyInfo: $storyInfo)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
            
            ContentText(storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    
            
            Divider()
                .frame(height: 1)
                .overlay(Color.oworiGray200)
        }
        .onAppear {
            storiesForCollection = storyViewModel.getStoriesForCollection()
        }
    }
}

struct DetailContent_Previews: PreviewProvider {
    static var previews: some View {
        DetailContent(isFavorite: .constant(true), storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
