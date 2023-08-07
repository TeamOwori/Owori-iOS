//
//  StoryView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryView: View {
    // MARK: PROPERTIES
    /// - true : 앨범형 / false : 리스트형
    @State private var buttonSet: Bool = true
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    @State private var stories: [Story.StoryInfo] = []
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                StoryViewHeader()
                HStack {
                    AlbumListButton(buttonSet: $buttonSet)
                    Spacer()
                    SortMenu()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                ScrollView {
                    if buttonSet {
                        StoryListView(stories: $stories)
                    } else {
                        StoryAlbumView(stories: $stories)
                    }
                }
            }
            .onAppear {
                storyViewModel.lookUpStory(user: userViewModel.user) {
                    stories = storyViewModel.getStoryTest()
                    print("[getStoryTest]\(stories)")
                }
            }
            RecordButton()
                // 임시로 설정
                .padding(.bottom, 30)
        }
        
    }
}


// MARK: PREVIEWS
struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
