//
//  LoginViewModel.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/13.
//

import SwiftUI
import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

fileprivate enum OworiAPI {
    static let scheme = "http"
    static let host = "localhost:8080"
    
    enum Path: String {
        case joinMember = "api/v1/members"
    }
}

class LoginViewModel: ObservableObject {
    
    // MARK: 카카오 로그인 관련 PROPERTIES
    @Published var kakaoUser: KakaoSDKUser.User?
    @Published var kakaoToken:  OAuthToken?
    
    // MARK: 애플 로그인 관련 PROPERTIES
    
    // MARK: 기타 PROPERTIES
    @Published var isLoggedIn: Bool = false
    //    @Published var user: User = UserViewModel().user
    @Published var socialToken: Token = Token()
    
    
    // MARK: 카카오 로그인 관련 FUNCTIONS
    
    // 로그인 분기 처리 함수
    func kakaoLogin(oworiUser: User) {
        // 카카오톡 설치 여부 확인 - 사용자의 핸드폰에 카카오 앱이 설치가 되어있는지?(카카오톡 설치여부)
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 설치가 되어있으면 카카오 앱을 통해 로그인 - loginWithKakaoTalk()
            handleLoginWithKakaoTalkApp {
                self.setUserInfo(oworiUser: oworiUser)
            }
        } else {    // 설치가 안되어있을 때
            // 카카오 웹 뷰로 로그인 - loginWithKakaoAccount()
            handleLoginWithKakaoAccount() {
                self.setUserInfo(oworiUser: oworiUser)
            }
        }
    }
    
    // 앱으로 로그인
    func handleLoginWithKakaoTalkApp(completion: @escaping () -> Void) {
        // 카카오톡 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    self.kakaoToken = oauthToken
                    self.isLoggedIn = true
                    completion()
                }
            }
        }
    }
    
    // 앱 없이 계정으로 로그인
    func handleLoginWithKakaoAccount(completion: @escaping () -> Void) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                self.kakaoToken = oauthToken
                self.isLoggedIn = true
                completion()
            }
        }
    }
    
    // 카카오 로그아웃
    func handleKakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                self.kakaoUser = nil
                self.isLoggedIn = false
            }
        }
    }
    
    // 카카오 유저 정보 불러오기
    func setUserInfo(oworiUser: User) {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            }
            else {
                if let user = user {
                    var scopes = [String]()
                    if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
                    if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
                    if (user.kakaoAccount?.birthdayNeedsAgreement == true) { scopes.append("birthday") }
                    if (user.kakaoAccount?.birthyearNeedsAgreement == true) { scopes.append("birthyear") }
                    if (user.kakaoAccount?.genderNeedsAgreement == true) { scopes.append("gender") }
                    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) { scopes.append("phone_number") }
                    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) { scopes.append("age_range") }
                    if (user.kakaoAccount?.ciNeedsAgreement == true) { scopes.append("account_ci") }
                    
                    if scopes.count > 0 {
                        print("사용자에게 추가 동의를 받아야 합니다.")
                        
                        // OpenID Connect 사용 시
                        // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
                        // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
                        // scopes.append("openid")
                        
                        //scope 목록을 전달하여 카카오 로그인 요청
                        UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
                            if let error = error {
                                print(error)
                            }
                            else {
                                UserApi.shared.me() { (user, error) in
                                    if let error = error {
                                        print(error)
                                    }
                                    else {
                                        print("me() success.")
                                        
                                        //do something
                                        _ = user
                                    }
                                }
                            }
                        }
                    }
                    else {
                        print("사용자의 추가 동의가 필요하지 않습니다.")
                    }
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                // Test Log
                // 추후 삭제 예정 코드 (user)
                self?.kakaoUser = user
                print("[Kakao user test log] : \(String(describing: self?.kakaoUser))")
                
                guard let socialToken = self?.kakaoToken else {
                    print("카카오 소셜 로그인 토큰이 정상적으로 발급되지 않았습니다.")
                    return
                }
                self?.socialToken = Token(authProvider: "KAKAO", accessToken: socialToken.accessToken, refreshToken: socialToken.refreshToken)
                print("[Kakao token test log]\(self?.socialToken)")
            }
            
        }
    }
    // MARK: 애플 로그인 관련 FUNCTIONS
    
    
    
    
}
