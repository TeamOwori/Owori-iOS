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
    private var lists = ["1", "2", "3", "4"]
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    // MARK: BODY
    var body: some View {
        VStack {
            ForEach(storyViewModel.storyModel.stories, id: \.self) { story in
                NavigationLink {
                    StoryDetailView(storyInfo: story)
                } label: {
                    DailyStoryListCell(storyInfo: story)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.oworiGray200)
                }
                .foregroundColor(.black)
                
            }
        }
    }
}

// MARK: PREVIEWS
struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
