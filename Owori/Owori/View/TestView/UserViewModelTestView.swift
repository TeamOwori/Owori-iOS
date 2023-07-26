//
//  UserViewModelTestView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct UserViewModelTestView: View {
    @EnvironmentObject  var loginViewModel: LoginViewModel
    @EnvironmentObject  var userViewModel: UserViewModel
    @EnvironmentObject  var storyViewModel: StoryViewModel
    @EnvironmentObject  var familyViewModel: FamilyViewModel
    
    var body: some View {
        VStack {
            Button {
                userViewModel.joinMember(socialToken: loginViewModel.socialToken)
            } label: {
                Text("Join Member(완)")
            }
            Button {
                userViewModel.initUser(userInfo: ["nickname" : "owori",
                                                  "birthday" : "2023-07-17"])
            } label: {
                Text("Init User(완)")
            }
            
            Button {
                userViewModel.updateProfile(userInfo: ["nickname" : "오월이",
                                                       "birthday" : "2023-07-14",
                                                       "color" : "GREEN"])
            } label: {
                Text("update Profile")
            }
            
            Button {
                userViewModel.updateEmotionalBadge(body: ["emotional_badge" : "HAPPY"])
            } label: {
                Text("update Emotional Badge(완)")
            }
            
            // 멤버 프로필 업데이트
            Button {
                userViewModel.updateProfile(userInfo: [ "nickname" : "owori",
                                                        "birthday" : "2023-07-18",
                                                        "color" : "GREEN"])
            } label: {
                Text("Update Member")
            }
            
            
            Button {
                userViewModel.refreshingToken()
            } label: {
                Text("Refreshing Token(완)")
            }
            
            
            
            Button {
                userViewModel.lookupUnmodifiableColor()
            } label: {
                Text("lookup Unmodifiable Color")
            }
            
            Button {
                userViewModel.deleteMember()
            } label: {
                Text("delete Member(완)")
            }
            
            Button {
                userViewModel.getDummyData()
            } label: {
                Text("get Dummy Data")
            }
            
            
            
        }
    }
}

struct UserViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        UserViewModelTestView()
    }
}
