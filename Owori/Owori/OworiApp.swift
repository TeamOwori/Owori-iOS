//
//  OworiApp.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/03.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct OworiApp: App {
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "6c28960f69d4c7f00043b02d890dd6e0")
    }
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var userViewModel = UserViewModel()
    var body: some Scene {
        
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
                .environmentObject(loginViewModel)
                .environmentObject(userViewModel)

        }
    }
}
