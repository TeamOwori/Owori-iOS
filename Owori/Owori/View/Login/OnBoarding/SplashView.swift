//
//  SplashView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isOnBoardingViewVisible = false
    
    var body: some View {
        ZStack {
            // 첫 번째 뷰
            VStack {
                if !isOnBoardingViewVisible {
                    Text("Main View")
                } else {
                    OnBoardingView()
                        .opacity(isOnBoardingViewVisible ? 1 : 0) // 천천히 나타나도록 투명도 조정
                }
            }
            .onAppear {
                // 3초 후에 다른 뷰로 전환
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) { // 애니메이션 적용
                        isOnBoardingViewVisible = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
