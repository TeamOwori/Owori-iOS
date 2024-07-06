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
                    SortMenu()
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

// MARK: - AlbumListButton

private struct AlbumListButton: View {
    @Binding var buttonSet: Bool
    
    var body: some View {
        HStack {
            Button {
                buttonSet = true
            } label: {
                Image("List").applyColorInvert(buttonSet)
            }
            Button {
                buttonSet = false
            } label: {
                Image("Album").applyColorInvert(!buttonSet)
            }
        }
    }
}

//struct AlbumListButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumListButton(buttonSet: .constant(true))
//    }
//}

// MARK: - SortMenu

private struct SortMenu: View {
    private var sortingMethods: [String] = ["최신순", "Text Text", "."]
    @State private var seletedMethod: String = "최신순"
    
    var body: some View {
        Menu {
            ForEach(sortingMethods, id: \.self) { method in
                Button {
                    seletedMethod = method
                } label: {
                    Text(method)
                }
            }
        } label: {
            HStack {
                Text(seletedMethod)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                Image("ArrowDown")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .foregroundColor(.gray)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
    }
}

//struct SortMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SortMenu()
//    }
//}

