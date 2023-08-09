//
//  StoryAlbumView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryAlbumView: View {
    // MARK: PROPERTIES
    /// - [임시] 컬렉션의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
//    private var collections = ["1", "2", "3", "4"]
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @Binding var stories: [Story.StoryInfo]
    @State private var storyInfo: Story.StoryInfo = Story.StoryInfo()
    @State private var storiesForCollection: [String: [Story.StoryInfo]] = [:]
    
    // MARK: BODY
    var body: some View {
        VStack {
            // 임시 테스트 storiViewModle -> stories로 사용해야됨
            ForEach(storiesForCollection.sorted(by: { $0.key < $1.key }), id: \.key) { yearAndMonth, collection in
                MonthlyStoryCollection(storiesForCollection: [yearAndMonth: collection], storyInfo: $storyInfo)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                Divider()
                    .frame(height: 1)
                    .overlay(Color.oworiGray200)
            }
        }
        .onAppear {
            storiesForCollection = storyViewModel.getStoriesForCollection()
            print("storiesForcollection Test log : \(storiesForCollection)")
        }
    }
}

// MARK: PREVIEWS
struct StoryAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAlbumView(stories: .constant([]))
    }
}
