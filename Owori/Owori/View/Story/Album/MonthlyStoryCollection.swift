//
//  MonthlyStoryCollection.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/03.
//

import SwiftUI

struct MonthlyStoryCollection: View {
    private let images = ["1", "2", "3", "4", "5"]
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())]
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Binding var storyInfo: Story.StoryInfo
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(storiesForCollection.sorted(by: { $0.key < $1.key}), id: \.key) { yearAndMonth, stories in
                Text(yearAndMonth.stringFromDate())
                    .font(.title3)
                    .bold()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(stories, id: \.self) { story in
                        Button {
                            storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: story.story_id!) { storyInfo in
                                self.storyInfo = storyViewModel.searchStoryByStoryId(story_id: story.story_id!)!
                                print("테스트테스트테스트\(story)")
                                storyDetailViewIsActiveFromStoryAlbum = true
                            }
                        } label: {
                            DailyStoryImageCell(storyInfo: .constant(story))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                                .clipped()
                                .cornerRadius(12)
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 20, trailing: 0))
        }
        .onAppear {
            storiesForCollection = storyViewModel.getStoriesForCollection()
            print("TEST StoriesForCollection : \(storiesForCollection)")
        }
    }
}

struct MonthlyStoryCollection_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyStoryCollection(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
    }
}
