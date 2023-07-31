//
//  MainView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            
            RealHomeView()
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
