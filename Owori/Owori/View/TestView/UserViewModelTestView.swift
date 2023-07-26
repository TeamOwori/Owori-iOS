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
                Text("Join Member")
            }
            Button {
                userViewModel.initUser(userInfo: ["nickname" : "owori",
                                                  "birthday" : "2023-07-17"])
            } label: {
                Text("Init User")
            }
            
            Button {
                userViewModel.lookupUnmodifiableColor()
            } label: {
                Text("lookupUnmodifiableColor")
            }
            
            // 멤버 프로필 업데이트
            Button {
                userViewModel.updateProfile(userInfo: [ "nickname" : "owori",
                                                        "birthday" : "2023-07-18",
                                                        "color" : "GREEN"])
            } label: {
                Text("Update Member")
            }
            
        }
    }
}

struct UserViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        UserViewModelTestView()
    }
}
