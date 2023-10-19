//
//  StoryView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryView: View {
    @State private var buttonSet: Bool = true
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @State private var isSearchViewVisible: Bool = false
    @State private var stories: [Story.StoryInfo] = []
    @State private var storiesForCollection: [String: [Story.StoryInfo]] = [:]
    @State private var storyDetailViewIsActive: Bool = false
    @State private var storyDetailViewIsActiveFromStoryAlbum: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                StoryViewHeader(isSearchViewVisible: $isSearchViewVisible)
                HStack {
                    AlbumListButton(buttonSet: $buttonSet)
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                ScrollView {
                    if buttonSet {
                        StoryListView(stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
                            .onAppear {
                                storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                                    stories = storyViewModel.getStories()
                                    print("[getStoryTest List]\(stories)")
                                }
                            }
                    } else {
                        StoryAlbumView(stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
                            .onAppear {
                                storyViewModel.lookUpStorySortByStartDate(user: userViewModel.user) {
                                    storiesForCollection = storyViewModel.getStoriesForCollection()
                                    print("storiesForcollection Test log : \(storiesForCollection)")
                                }
                            }
                    }
                }
            }
            RecordButton(stories: $stories, storiesForCollection: $storiesForCollection)
                .padding(.bottom, 30)
        }
        .navigationDestination(isPresented: $isSearchViewVisible) {
            StorySearchView()
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
