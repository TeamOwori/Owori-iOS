//
//  StoryViewModelTestView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct StoryViewModelTestView: View {
    @EnvironmentObject  var loginViewModel: LoginViewModel
    @EnvironmentObject  var userViewModel: UserViewModel
    @EnvironmentObject  var storyViewModel: StoryViewModel
    @EnvironmentObject  var familyViewModel: FamilyViewModel
    var body: some View {
        VStack {
            Button {
                storyViewModel.createStory(user: userViewModel.user, storyInfo: [
                    "start_date" : "20230806",
                    "end_date" : "20230807",
                    "title" : "Test Story",
                    "content" : "Test Story",
                    "story_images" : [ /* "https://owori.s3.ap-northeast-2.amazonaws.com/profile-image/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-07-22+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+5.04.20.png"*/ ]
                ]) {
                    
                }
            } label: {
                Text("Create Story")
            }
            
            Button {
                storyViewModel.updateStory(user: userViewModel.user, storyInfo: [
                    "story_id" : "\(storyViewModel.testStoryId)",
                    "start_date" : "20221225",
                    "end_date" : "20221225",
                    "title" : "기다리고 기다리던 하루",
                    "content" : "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ ",
                    "story_images" : [ /* "https://owori.s3.ap-northeast-2.amazonaws.com/profile-image/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-07-22+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+5.04.20.png"*/ ]
                ]) {}
            } label: {
                Text("Update Story")
            }
            
            Button {
                storyViewModel.lookUpStory(user: userViewModel.user) {
                    
                }
            } label: {
                Text("lookUp Story")
            }
            
            Button {
                storyViewModel.lookUpStoryDetail(user: userViewModel.user, storyId: storyViewModel.testStoryId) {
                    
                }
            } label: {
                Text("lookUp Story Detail")
            }
            
            Button {
                storyViewModel.deleteStory(user: userViewModel.user, storyId: storyViewModel.testStoryId) {
//                    storyViewModel.lookUpStory(user: userViewModel.user) {
//
//                    }
                }
            } label: {
                Text("delete Story")
            }
        }
    }
}

struct StoryViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        StoryViewModelTestView()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
            .environmentObject(LoginViewModel())
            .environmentObject(StoryViewModel())
    }
}
