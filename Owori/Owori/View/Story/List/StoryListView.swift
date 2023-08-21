//
//  StoryListView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryListView: View {
    // MARK: PROPERTIES
    /// - [임시] 리스트의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
    
    // 근데 왜 여기 private를 넣으면 에러가 나는지 이해를 못하겠음...
    //    private var lists = ["1", "2", "3", "4"]
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @State private var storyInfo: Story.StoryInfo = Story.StoryInfo()
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    
    // MARK: BODY
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

// MARK: PREVIEWS
struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView(stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
