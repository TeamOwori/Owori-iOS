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
    
    // MARK: BODY
    var body: some View {
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
                    StoryListView()
                } else {
                    StoryAlbumView()
                }
            }
        }
        .onAppear {
            storyViewModel.lookUpStoryLatestOrder(user: userViewModel.user)
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
