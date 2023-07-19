//
//  TabbarView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct TabbarView: View {
    // 탭 태그 번호
    @State private var selectedTab = 0
    
    init() {
        // 탭 바 색상 고정
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = .white
        // 스크롤 할 때, 스크롤하지 않을 때의 색상 적용
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    if selectedTab == 0 {
                        Image("HomeSelected")
                    } else {
                        Image("HomeUnselected")
                    }
                }
                .tag(0)
            
            // MARK: + CalendarView()
            
            StoryView()
                .tabItem {
                    if selectedTab == 0 {
                        Image("StoryUnSelected")
                    } else {
                        Image("StorySelected")
                    }
                }
                .tag(2)
        }
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
