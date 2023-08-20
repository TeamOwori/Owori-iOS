//
//  StoryDetailView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct StoryDetailView: View {
    @State private var images: [String] = ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]
    @State private var currentIndex: Int = 0
    @State private var isFavorite: Bool = true
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    @Binding var storyInfo: Story.StoryInfo
    
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ImageTabView(storyInfo: $storyInfo, currentIndex: $currentIndex)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                    .clipped()
                
                VStack(spacing: 0) {
                    HorizontalImageScrollView(images: storyInfo.story_images ?? [], currentIndex: $currentIndex)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    DetailContent(isFavorite: $isFavorite, storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive)
                    Comment()
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 20, trailing: 0))
                    Recomment()
                        .padding(EdgeInsets(top: 0, leading: 50, bottom: 20, trailing: 0))
                    CommentsView()
                    
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .navigationTitle(Text(""))
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            storiesForCollection = storyViewModel.getStoriesForCollection()
            print("StoryDetailView log : \(storyInfo)")
        }
        
    }
}



struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
