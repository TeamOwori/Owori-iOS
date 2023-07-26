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
                Text("Add FamilyMember")
            }
            
            
            
            Button {
                familyViewModel.LookupFamilyInfo(user: userViewModel.user)
            } label: {
                Text("Lookup Family")
            }
            
        }
    }
}

struct FamilyViewModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyViewModelTestView()
    }
}
