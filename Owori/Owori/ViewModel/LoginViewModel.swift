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
    @Published var user: User = User()
    @Published var socialToken: Token = Token()
    
    
    // MARK: 카카오 로그인 관련 FUNCTIONS
    
    // 로그인 분기 처리 함수
    func kakaoLogin() {
        // 카카오톡 설치 여부 확인 - 사용자의 핸드폰에 카카오 앱이 설치가 되어있는지?(카카오톡 설치여부)
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 설치가 되어있으면 카카오 앱을 통해 로그인 - loginWithKakaoTalk()
            handleLoginWithKakaoTalkApp {
                self.setUserInfo()
            }
        } else {    // 설치가 안되어있을 때
            // 카카오 웹 뷰로 로그인 - loginWithKakaoAccount()
            handleLoginWithKakaoAccount() {
                self.setUserInfo()
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
    func setUserInfo() {
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
            // Test Log
            self.kakaoUser = user
            print("[Kakao user test log] : \(String(describing: self.kakaoUser))")
            
            guard let socialToken = self.kakaoToken else {
                print("카카오 소셜 로그인 토큰이 정상적으로 발급되지 않았습니다.")
                return
            }
            self.socialToken = Token(authProvider: "KAKAO", accessToken: socialToken.accessToken, refreshToken: socialToken.refreshToken)
            print("[Kakao token test log]\(self.socialToken)")
        }
    }
    // MARK: 애플 로그인 관련 FUNCTIONS
    
    // MARK: 오월이 API FUNCTIONS
    func joinMember() {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["token": socialToken.accessToken, "auth_provider": socialToken.authProvider], options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        //        var urlComponents = URLComponents()
        //        urlComponents.scheme = OworiAPI.scheme
        //        urlComponents.host = OworiAPI.host
        //        urlComponents.path = OworiAPI.Path.joinMember.rawValue
        //        guard let url = urlComponents.url else {
        //            print("Error: cannot create URL")
        //            return
        //        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        let url = URL(string: "http://localhost:8080/api/v1/members")!
        
        // url 테스트 log
        print("[joinMember url Log : ]\(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = sendData
        
        // 요청
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response else {
                print("Error: response error")
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed2")
                return
            }
            
            // User를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async {
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    self.user = try decoder.decode(User.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Member ID: \(self.user.member_id)")
                    print("Access Token: \(self.user.jwt_token.access_token)")
                    print("Refresh Token: \(self.user.jwt_token.refresh_token)")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
}
