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
    static let host = "owori.store"
    
    enum Path: String {
        case joinMember = "/api/v1/members"
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
    func kakaoLogin(oworiUser: User, completion: @escaping () -> Void) {
        // 하나 이상의 비동기 작업을 그룹화하여 해당 그룹 내의 모든 작업이 완료되었는지 확인할 수 있는 클래스 선언
        let dispatchGroup = DispatchGroup()
        
        // 카카오톡 설치 여부 확인 - 사용자의 핸드폰에 카카오 앱이 설치가 되어있는지?(카카오톡 설치여부)
        if UserApi.isKakaoTalkLoginAvailable() {
            // 비동기 작업 그룹에 추가
            dispatchGroup.enter()
            // 설치가 되어있으면 카카오 앱을 통해 로그인 - loginWithKakaoTalk()
            handleLoginWithKakaoTalkApp {
                self.setUserInfo(oworiUser: oworiUser) {
                    self.getSocialTokenForKakao()
                    //비동기 작업 그룹에서 제거
                    dispatchGroup.leave()
                }
            }
        } else {    // 설치가 안되어있을 때
            // 비동기 작업 그룹에 추가
            dispatchGroup.enter()
            handleLoginWithKakaoAccount() {
                self.setUserInfo(oworiUser: oworiUser) {
                    self.getSocialTokenForKakao()
                    // 비동기 작업 그룹에서 제거
                    dispatchGroup.leave()
                }
            }
        }
        
        // 그룹 내의 모든 비동기 작업이 완료되면 norify 내의 코드 실행 (main 큐에서)
        dispatchGroup.notify(queue: .main) {
            completion()
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
    func setUserInfo(oworiUser: User, completion: @escaping () -> Void) {
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
            completion()
        }
    }
    
    func getSocialTokenForKakao() {
        DispatchQueue.main.async { [weak self] in
            // Test Log
            // 추후 삭제 예정 코드 (user)
            //            self?.kakaoUser = user
            //            print("[Kakao user test log] : \(String(describing: self?.kakaoUser))")
            
            guard let socialToken = self?.kakaoToken else {
                print("카카오 소셜 로그인 토큰이 정상적으로 발급되지 않았습니다.")
                return
            }
            self?.socialToken = Token(authProvider: "KAKAO", accessToken: socialToken.accessToken, refreshToken: socialToken.refreshToken)
            print("[Kakao token test log]\(self?.socialToken)")
        }
    }
    
    
    // MARK: 애플 로그인 관련 FUNCTIONS
    
    func appleLoginButton(completion: @escaping () -> Void) -> some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        // 계정 정보 가져오기
                        let UserIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        
                        DispatchQueue.main.async { [weak self] in
                            
                            self?.socialToken = Token(authProvider: "APPLE", accessToken: IdentityToken!, refreshToken: IdentityToken!)
                            
                            // 테스트 로그
                            print("애플 로그인 테스트 : \(self?.socialToken)")
                            
//                            print("UserIdentifier: \(UserIdentifier)")
//                            print("IdentityToken: \(IdentityToken)")
//                            print("AuthorizationCode: \(AuthorizationCode)")
                            self?.isLoggedIn = true
                            
                            completion()
                        }
                        
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .frame(width: 300, height: 44, alignment: .leading)
        .cornerRadius(12)
//        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
//        .cornerRadius(5)
    }
    
    
}
