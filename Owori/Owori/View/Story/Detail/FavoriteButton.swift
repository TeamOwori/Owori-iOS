//
//  FavoriteButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    @Binding var storyInfo: Story.StoryInfo
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    var body: some View {
        Button {
            isFavorite.toggle()
            storyViewModel.toggleHeart(user: userViewModel.user, storyId: storyInfo.story_id!) {
                storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: storyInfo.story_id!) { storyInfo in
                    self.storyInfo = storyInfo
                }
            }
            
        } label: {
            VStack {
                Image(isFavorite ? "FavoriteFill" : "FavoriteUnfill")
            }
        }
        
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorite: .constant(true), storyInfo: .constant(Story.StoryInfo()))
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}
