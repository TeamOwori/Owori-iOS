//
//  StoryListView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryListView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @State private var storyInfo: Story.StoryInfo = Story.StoryInfo()
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    var body: some View {
        VStack {
            ForEach($stories, id: \.self) { $story in
                Button {
                    storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: story.story_id!) { storyInfo in
                        self.storyInfo = storyViewModel.searchStoryByStoryId(story_id: story.story_id!)!
                        print("테스트테스트테스트\(story)")
                        storyDetailViewIsActive = true
                    }
                } label: {
                    DailyStoryListCell(storyInfo: $story)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.oworiGray200)
                }
                .foregroundColor(.black)
            }
        }
        .onAppear {
            print("리스트 테스트")
            print(stories)
        }
        .navigationDestination(isPresented: $storyDetailViewIsActive) {
            StoryDetailView(storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView(stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
