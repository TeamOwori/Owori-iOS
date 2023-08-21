//
//  UserViewModel.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/14.
//

import SwiftUI

fileprivate enum OworiAPI {
    static let scheme = "http"
    static let host = "13.124.20.243"
    
    enum Path: String {
        case members = "/api/v1/members"
        case membersKakao = "/api/v1/members/kakao"
        case membersApple = "/api/v1/members/apple"
        case refresh = "/api/v1/auth/refresh"
        case membersDetails = "/api/v1/members/details"
        case membersEmtionalBadge = "/api/v1/members/emotional-badge"
        case membersProfile = "/api/v1/members/profile"
        case membersColors = "/api/v1/members/colors"
        case membersProfileImage = "/api/v1/members/profile-image"
    }
}

class UserViewModel: ObservableObject {
    @Published var user: User = User()
    @Published var isLogined = false
    
    @Published var tempInviteCode: String = ""
    
    
    func userLogout() {
        self.user = User()
        isLogined = false
        print(user)
        print("로그아웃 성공(유저 초기화)")
    }
    
    // MARK: 오월이 API FUNCTIONS (Post)
    
    // 멤버 홈화면 조회
    func joinMember(socialToken: Token, completion: @escaping () -> Void) {
        
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        if socialToken.authProvider == "KAKAO" {
            urlComponents.path = OworiAPI.Path.membersKakao.rawValue
        } else {
            urlComponents.path = OworiAPI.Path.membersApple.rawValue
        }
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members")!
        
        // url 테스트 log
        print("[joinMember url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if socialToken.authProvider == "KAKAO" {
            guard let sendData = try? JSONSerialization.data(withJSONObject: ["token": socialToken.accessToken, "auth_provider": socialToken.authProvider], options: []) else { return }
            urlRequest.httpBody = sendData
        } else if socialToken.authProvider == "APPLE" {
            guard let sendData = try? JSONSerialization.data(withJSONObject: ["token": socialToken.accessToken, "auth_provider": socialToken.authProvider, "authorization_code" : socialToken.authorizationCode], options: []) else { return }
            urlRequest.httpBody = sendData
        }
        
        
        
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
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            print(jsonDictionary)
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // User를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    self?.user = try decoder.decode(User.self, from: data)
                    self?.user.jwt_token?.auth_provider = socialToken.authProvider
                    self?.isLogined = true
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Member ID: \(String(describing: self?.user.member_id))")
                    print("Access Token: \(String(describing: self?.user.jwt_token?.access_token))")
                    print("Refresh Token: \(String(describing: self?.user.jwt_token?.refresh_token))")
                    print("Auth Provider: \(self?.user.jwt_token?.auth_provider ?? "Empty Provider")")
                    print("Member: \(self?.user)")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
                completion()
            }
        }.resume()
    }
    
    func initUser(userInfo: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else { return }
        
        //         요청을 보낼 API의 url 설정
        //         배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersDetails.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members/details")!
        
        // url 테스트 log
        print("[init User url Log]: \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            print("Init Profile test : \(jsonDictionary)")
            print(error)
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                // Test Log
                self?.user.is_service_member = jsonDictionary["is_service_member"] as! Bool
                //                self?.user.member_profile = User.Profile(nickname: userInfo["nickname"] as! String, birthday: userInfo["birthday"] as! String)
                print(jsonDictionary["is_service_member"] as! Bool)
                print(userInfo["nickname"] as! String)
                print(userInfo["birthday"] as! String)
                //                print(self?.user)
                completion()
            }
            
            
        }.resume()
    }
    
    func updateEmotionalBadge(body: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        //         요청을 보낼 API의 url 설정
        //         배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersEmtionalBadge.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members/emotional-badge")!
        
        // url 테스트 log
        print("[init User url Log]: \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print(response)
            completion()
        }.resume()
    }
    
    
    // 멤버 프로필 업데이트
    func updateProfile(userInfo: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersProfile.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members/profile")!
        
        // url 테스트 log
        print("[Update Profile User url Log]: \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
            
            print(response)
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                
               completion()
            }
            
        }.resume()
    }
    
    func uploadProfileImages(image: UIImage, completion: @escaping (String) -> Void) {
        var uploadedProfileImageUrl: String = ""
        
        // 이미지 로그 테스트
        print("이미지 로그 테스트 : \(image)")
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersProfileImage.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/stories/update\(storyId)")!
        
        // url 테스트 log
        print("[uploadImages url Log] : \(url)")
        
        let boundary = "\(UUID().uuidString)"
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("applecation/json", forHTTPHeaderField: "Accpet")
        
        // body 설정
        var body = Data()
        
        
        let imageName = "profileImage.jpeg"
        
        
        if let boundaryPrefix = "--\(boundary)\r\n".data(using: .utf8),
           let dispositionData = "Content-Disposition: form-data; name=\"profile_image\"; filename=\"\(imageName)\"\r\n".data(using: .utf8),
           let contentTypeData = "Content-Type: image/jpg\r\n\r\n".data(using: .utf8),
           let imageData = image.jpegData(compressionQuality: 0.5),
           let lineBreakData = "\r\n".data(using: .utf8) {
            
            body.append(boundaryPrefix)
            body.append(dispositionData)
            body.append(contentTypeData)
            body.append(imageData)
            body.append(lineBreakData)
        }
        
        
        if let boundaryEndData = "--\(boundary)--\r\n".data(using: .utf8) {
            body.append(boundaryEndData)
        }
        
        urlRequest.httpBody = body
        
        // 요청
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print(data)
            print(response)
            print(error)
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            print(jsonDictionary)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    //                    let decoder = JSONDecoder()
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    
                    
                    print(jsonDictionary)
                    print("성공")
                    uploadedProfileImageUrl = jsonDictionary["profile_image"] as! String
                    completion(uploadedProfileImageUrl)
                    //                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("[Story Model Log]: \(self?.storyModel)")
                    
                } catch {
                    print("[uploadImages] Error: Failed to parse JSON data - \(error)")
                }
            }
            
        }.resume()
        
    }
    
    // MARK: 오월이 API FUNCTIONS (GET)
    func refreshingToken() {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.refresh.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/auth/refresh")!
        
        // url 테스트 log
        print("[refreshingToken url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.jwt_token?.access_token, forHTTPHeaderField: "accessToken")
        urlRequest.setValue(self.user.jwt_token?.refresh_token, forHTTPHeaderField: "refreshToken")
        
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
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            print(jsonDictionary)
            
            // User를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let authProvider = self?.user.jwt_token?.auth_provider
                    let decoder = JSONDecoder()
                    self?.user.jwt_token = try decoder.decode(User.JwtToken.self, from: data)
                    self?.user.jwt_token?.auth_provider = authProvider
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Member ID: \(String(describing: self?.user.member_id))")
                    print("Access Token: \(String(describing: self?.user.jwt_token?.access_token))")
                    print("Refresh Token: \(String(describing: self?.user.jwt_token?.refresh_token))")
                    print("Auth Provider: \(self?.user.jwt_token?.auth_provider ?? "Empty Provider")")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // 유저 마이 프로필 조회
    func lookupProfile(completion: @escaping () -> Void) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersProfile.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members/profile")!
        
        // url 테스트 log
        print("[lookupProfile url Log] : \(urlComponents)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            
            print(response)
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            print(jsonDictionary)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            
            // User를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    self?.user.member_profile = try decoder.decode(User.Profile.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Member Profile: \(String(describing: self?.user.member_profile))")
                    completion()
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func lookupUnmodifiableColor(completion: @escaping ([String: Any]) -> Void) {
        var usedColorList: [String: Any] = [:]
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersColors.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members/colors")!
        
        // url 테스트 log
        print("[lookupUnmodifiableColor url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print(response)
            
            print(jsonDictionary)
            
            // User를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    //                    let decoder = JSONDecoder()
                    usedColorList = jsonDictionary
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("Member Profile: \(String(describing: self?.user.member_profile))")
                    completion(usedColorList)
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func getDummyData() {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        //        var urlComponents = URLComponents()
        //        urlComponents.scheme = OworiAPI.scheme
        //        urlComponents.host = OworiAPI.host
        //        urlComponents.path = OworiAPI.Path.lookupUnmodifiableColor.rawValue
        //        guard let url = urlComponents.url else {
        //            print("Error: cannot create URL")
        //            return
        //        }
        //
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        let url = URL(string: "http://13.124.20.243/api/v1/tests")!
        
        // url 테스트 log
        print("[get dommy data url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            guard let jsonString = String(data: data, encoding: .utf8) else {
                print("Error: Failed to convert data to string")
                return
            }
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print(response)
            print(jsonString)
            
            // User를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    self?.tempInviteCode = jsonString
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: 오월이 API FUNCTIONS (DELETE)
    func deleteMember() {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.members.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/members")!
        
        // url 테스트 log
        print("[delete Member url Log : ]\(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            //            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
            //                print("Error: convert failed json to dictionary")
            //                return
            //            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            print(response)
        }.resume()
    }
}
