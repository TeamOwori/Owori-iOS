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
                    "start_date" : "2022-12-25",
                    "end_date" : "2022-12-30",
                    "title" : "기다리고 기다리던 하루",
                    "contents" : "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ ",
                    "image_id" : [ "25565629-4fd0-4dde-81ff-f178379a6204", "9c0263bf-eed1-43f6-93e2-1be7cbb90ca8", "6c671071-fdef-4e08-97c8-62c8793a86d1", "23e71df3-1581-4cfd-ac87-57da7c03794d", "51ab1978-b402-42fd-aa76-affb47efe054", "d7d46a6a-b71c-434c-8d42-ef00492b8bd6" ]
                ])
            } label: {
                Text("Create Story")
            }
            
            Button {
            storyViewModel.updateStory(user: userViewModel.user, storyInfo: [
                "start_date" : "2022-12-25",
                "end_date" : "2022-12-30",
                "title" : "기다리고 기다리던 하루",
                "contents" : "종강하면 동해바다로 가족 여행 가자고 한게 엊그제 같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ ",
                "image_id" : [ "25565629-4fd0-4dde-81ff-f178379a6204", "9c0263bf-eed1-43f6-93e2-1be7cbb90ca8", "6c671071-fdef-4e08-97c8-62c8793a86d1", "23e71df3-1581-4cfd-ac87-57da7c03794d", "51ab1978-b402-42fd-aa76-affb47efe054", "d7d46a6a-b71c-434c-8d42-ef00492b8bd6" ]
            ])
        } label: {
            Text("Update Story")
        }
            
        }
    }
}

struct StoryViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        StoryViewModelTestView()
    }
}
