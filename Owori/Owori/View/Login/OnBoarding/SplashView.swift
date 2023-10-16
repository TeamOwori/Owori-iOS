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
            Color.oworiOrange.edgesIgnoringSafeArea(.all)
            VStack {
                if !isOnBoardingViewVisible {
                    Image("오월이타이틀")
                } else {
                    OnBoardingView()
                        .opacity(isOnBoardingViewVisible ? 1 : 0)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) {
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
