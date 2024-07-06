//
//  MainView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @State private var selectedTab = 0
    @State private var emotionalBadgeViewIsActive: Bool = false
    @State private var myPageViewIsActive: Bool = false
    @State private var isAddDdayViewActive: Bool = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        if emotionalBadgeViewIsActive {
            SelectEmotionBadge(emotionalBadgeViewIsActive: $emotionalBadgeViewIsActive)
        } else {
            TabView(selection: $selectedTab) {
                RealHomeView(emotionalBadgeViewIsActive: $emotionalBadgeViewIsActive, isLoggedIn: $isLoggedIn, myPageViewIsActive: $myPageViewIsActive, isAddDdayViewActive: $isAddDdayViewActive)
                    .tabItem {
                        if selectedTab == 0 {
                            Image("HomeTabSelected")
                        } else {
                            Image("HomeTabUnselected")
                        }
                    }
                    .tag(0)
                    .onAppear {
                        familyViewModel.lookUpHomeView(user: userViewModel.user) {
                            print(familyViewModel.getFamily())
                        }
                    }
                StoryView()
                    .tabItem {
                        if selectedTab == 2 {
                            Image("StoryTabSelected")
                        } else {
                            Image("StoryTabUnselected")
                        }
                    }
                    .tag(2)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                userViewModel.lookupProfile() {}
                familyViewModel.lookUpHomeView(user: userViewModel.user) { }
            }
            .navigationBarBackButtonHidden(true)
        }   
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(isLoggedIn: .constant(true))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
