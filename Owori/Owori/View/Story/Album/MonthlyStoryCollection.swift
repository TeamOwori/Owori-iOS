//
//  MonthlyStoryCollection.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/03.
//

import SwiftUI

struct MonthlyStoryCollection: View {
    // MARK: PROPERTIES
    
    /// - [임시] 모델의 이미지를 대신하기 위한 변수
    /// - 실제 데이터 들어오면 없어질 예정
    private let images = ["1", "2", "3", "4", "5"]
    
    /// - 표시할 열의 수
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    //    @Binding var storyInfo: Story.StoryInfo
//    var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyInfo: Story.StoryInfo
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool
    
    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) {
            
            ForEach(storiesForCollection.sorted(by: { $0.key < $1.key}), id: \.key) { yearAndMonth, stories in
                // 날짜
                Text(yearAndMonth.stringFromDate())
                    .font(.title3)
                    .bold()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                
                // Album Collection View
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(stories, id: \.self) { story in
                        Button {
                            storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: story.story_id!) {
                                storyInfo = storyViewModel.searchStoryByStoryId(story_id: story.story_id!)!
                                print("테스트테스트테스트\(story)")
                                storyDetailViewIsActiveFromStoryAlbum = true
                            }
                        } label: {
                            // 임시
                            //                            Text("\(story.title!)")
                            // 바인딩 된 값은... .constant()로 묶어서 보내면 바인딩처리 해줄 수 있습니다...
                            // 이렇게 하니까 제대로 동작 안합니다... storyInfo에 바인딩된 값을 넘겨줄 수 있도록 처리하는 방법을
                            // 찾아봅시다
                            // 일단 백앤드에서 thumbnail 넘겨줘서 임시로 처리하긴 했지만
                            // ForEach에서 반복자를 바인딩해서 넘기는 방법을 알아봐야될 것 같습니다.
                            DailyStoryImageCell(storyInfo: .constant(story))
                                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
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


// MARK: PREVIEWS
struct MonthlyStoryCollection_Previews: PreviewProvider {
    static var previews: some View {
//        MonthlyStoryCollection(stories: .constant([]), storiesForCollection: ["2023-08": [ Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"), Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"), Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")]], storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")))
        MonthlyStoryCollection(storyInfo: .constant(Story.StoryInfo(id: 0, story_id: "0", is_liked: true, story_images: [], thumbnail: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08")), stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
    }
}
