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
    
    var storyInfo: Story.StoryInfo
    
    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) {
            // 날짜
            Text("yyyy.MM".stringFromDate())
                .font(.title3)
                .bold()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            // Album Collection View
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(storyViewModel.storyModel.stories, id: \.self) { story in
                    NavigationLink {
//                        StoryDetailView()
                    } label: {
                        DailyStoryImageCell(storyImage: story.image ?? "DefaultImage", storyImagesNumber: story.images?.count ?? 1)
                            .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                    }
                }
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 20, trailing: 0))
        }
    }
}


// MARK: PREVIEWS
struct MonthlyStoryCollection_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyStoryCollection(storyInfo: Story.StoryInfo(id: 0, story_id: "0", is_liked: true, images: [], image: "DefaultImage", title: "Test", writer: "Test", content: "Test", comments: [], heart_count: 0, comment_count: 0, start_date: "2023-07-07", end_date: "2023-07-08"))
    }
}
