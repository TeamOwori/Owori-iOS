//
//  FamilyViewModelTestView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct FamilyViewModelTestView: View {
    @EnvironmentObject  var loginViewModel: LoginViewModel
    @EnvironmentObject  var userViewModel: UserViewModel
    @EnvironmentObject  var storyViewModel: StoryViewModel
    @EnvironmentObject  var familyViewModel: FamilyViewModel
    var body: some View {
        VStack {
            Button {
                familyViewModel.addFamilyMember(user: userViewModel.user, family_group_name: "owori")
            } label: {
                Text("Add FamilyMember(완)")
            }
            
            Button {
                familyViewModel.addFamilyMemberInviteCode(user: userViewModel.user, invite_code: userViewModel.tempInviteCode)
            } label: {
                Text("add Family Member Invite Code(완)")
            }
            
            Button {
                familyViewModel.changeFamilyName(user: userViewModel.user, family_group_name: "owori7")
                
            } label: {
                Text("change Family Name(완)")
            }
            
            Button {
                familyViewModel.LookupFamilyInfo(user: userViewModel.user)
            } label: {
                Text("Lookup Family")
            }
            
            Button {
                familyViewModel.regenInvitecode(user: userViewModel.user)
            } label: {
                Text("regen Invitecode(완)")
            }
            
        }
    }
}

struct FamilyViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyViewModelTestView()
    }
}
