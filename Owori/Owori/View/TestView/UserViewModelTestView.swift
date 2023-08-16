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
                userViewModel.joinMember(socialToken: loginViewModel.socialToken) {
                    print(userViewModel.user.is_service_member!)
                }
            } label: {
                Text("Join Member(완)")
            }
            Button {
                userViewModel.initUser(userInfo: ["nickname" : "owori",
                                                  "birthday" : "20230717"]) {
                    
                }
            } label: {
                Text("Init User(완)")
            }
            
            Button {
                userViewModel.updateProfile(userInfo: ["nickname" : "오월이",
                                                       "birthday" : "20230714",
                                                       "color" : "GREEN"])
            } label: {
                Text("update Profile(완)")
            }
            
            Button {
                userViewModel.updateEmotionalBadge(body: ["emotional_badge" : "HAPPY"]) {
                    
                }
            } label: {
                Text("update Emotional Badge(완)")
            }
    
            
            
            Button {
                userViewModel.refreshingToken()
            } label: {
                Text("Refreshing Token(완)")
            }
            
            Button {
                userViewModel.lookupProfile() {
                    
                }
            } label: {
                Text("lookup Profile(완)")
            }
            
            
            
            Button {
                userViewModel.lookupUnmodifiableColor() { usedColorList in
                    
                }
            } label: {
                Text("lookup Unmodifiable Color(완)")
            }
            
            Button {
                userViewModel.deleteMember()
            } label: {
                Text("delete Member(완)")
            }
            
            Button {
                userViewModel.getDummyData()
            } label: {
                Text("get Dummy Data(완)")
            }
            
            
            
        }
    }
}

struct UserViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        UserViewModelTestView()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
            .environmentObject(LoginViewModel())
            .environmentObject(StoryViewModel())
    }
}
