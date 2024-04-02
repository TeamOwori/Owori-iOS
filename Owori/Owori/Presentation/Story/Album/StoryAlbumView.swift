//
//  StoryAlbumView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryAlbumView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    @State private var storyInfo: Story.StoryInfo = Story.StoryInfo()
    @Binding var stories: [Story.StoryInfo]
    @Binding var storiesForCollection: [String: [Story.StoryInfo]]
    @Binding var storyDetailViewIsActive: Bool
    @Binding var storyDetailViewIsActiveFromStoryAlbum: Bool

    var body: some View {
        VStack {
            ForEach(storiesForCollection.sorted(by: { $0.key > $1.key }), id: \.key) { yearAndMonth, collection in
                MonthlyStoryCollection(storyInfo: $storyInfo, stories: $stories, storiesForCollection: Binding.constant([yearAndMonth: collection]),storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                Divider()
                    .frame(height: 1)
                    .overlay(Color.oworiGray200)
            }
        }
        .navigationDestination(isPresented: $storyDetailViewIsActiveFromStoryAlbum) {
            StoryDetailView(storyInfo: $storyInfo, stories: $stories, storiesForCollection: $storiesForCollection, storyDetailViewIsActive: $storyDetailViewIsActive, storyDetailViewIsActiveFromStoryAlbum: $storyDetailViewIsActiveFromStoryAlbum)
        }
        .onAppear {
            storiesForCollection = storyViewModel.getStoriesForCollection()
            print("storiesForcollection Test log : \(storiesForCollection)")
        }
    }
}

struct StoryAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAlbumView(stories: .constant([]), storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(false), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
    }
}
