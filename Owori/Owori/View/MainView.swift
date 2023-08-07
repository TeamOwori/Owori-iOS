//
//  MainView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @State private var emotionalBadgeViewIsActive: Bool = false
    
    var body: some View {
        if emotionalBadgeViewIsActive {
            SelectEmotionBadge(emotionalBadgeViewIsActive: $emotionalBadgeViewIsActive)
        } else {
            TabView(selection: $selectedTab) {
                RealHomeView(emotionalBadgeViewIsActive: $emotionalBadgeViewIsActive)
                    .tabItem {
                        if selectedTab == 0 {
                            Image("HomeTabSelected")
                        } else {
                            Image("HomeTabUnselected")
                        }
                    }
                    .tag(0)
                
                StoryView()
                    .tabItem {
                        if selectedTab == 1 {
                            Image("StoryTabSelected")
                        } else {
                            Image("StoryTabUnselected")
                        }
                    }
                    .tag(1)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
