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
        case membersGoogle = "/api/v1/members/google"
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
    // 얘를 인터페이스로 바꾸기.
    func joinMember(socialToken: Token, completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        if socialToken.authProvider == "KAKAO" {
            urlComponents.path = OworiAPI.Path.membersKakao.rawValue
        } else if socialToken.authProvider == "APPLE" {
            urlComponents.path = OworiAPI.Path.membersApple.rawValue
        } else if socialToken.authProvider == "GOOGLE" {
            urlComponents.path = OworiAPI.Path.membersGoogle.rawValue
        }
        guard let url = urlComponents.url else {
            print("[joinMember] Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if socialToken.authProvider == "KAKAO" {
            guard let sendData = try? JSONSerialization.data(withJSONObject: ["token": socialToken.accessToken, "auth_provider": socialToken.authProvider], options: []) else { return }
            urlRequest.httpBody = sendData
        } else if socialToken.authProvider == "APPLE" {
            guard let sendData = try? JSONSerialization.data(withJSONObject: ["token": socialToken.accessToken, "auth_provider": socialToken.authProvider, "authorization_code" : socialToken.authorizationCode], options: []) else { return }
            urlRequest.httpBody = sendData
        } else if socialToken.authProvider == "GOOGLE" {
            guard let sendData = try? JSONSerialization.data(withJSONObject: ["token": socialToken.accessToken, "auth_provider": socialToken.authProvider], options: []) else { return }
            urlRequest.httpBody = sendData
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("[joinMember] Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("[joinMember] Error: Did not receive data")
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("[joinMember] Error: convert failed json to dictionary")
                return
            }
            print(error)
            print(data)
            print(response)
            print(jsonDictionary)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("[joinMember] Error: HTTP request failed")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                do {
                    let decoder = JSONDecoder()
                    self?.user = try decoder.decode(User.self, from: data)
                    self?.user.jwt_token?.auth_provider = socialToken.authProvider
                    self?.isLogined = true
                    
                    print("Member ID: \(String(describing: self?.user.member_id))")
                    print("Access Token: \(String(describing: self?.user.jwt_token?.access_token))")
                    print("Refresh Token: \(String(describing: self?.user.jwt_token?.refresh_token))")
                    print("Auth Provider: \(self?.user.jwt_token?.auth_provider ?? "Empty Provider")")
                    print("Member: \(self?.user)")
                } catch {
                    print("[joinMember] Error: Failed to parse JSON data - \(error)")
                }
                completion()
            }
        }.resume()
    }
    
    func initUser(userInfo: [String: Any], completion: @escaping (Bool) -> Void) {
        var success: Bool = false
        guard let sendData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersDetails.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = sendData
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                completion(success)
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                completion(success)
                return
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                print("Error: convert failed json to dictionary")
                completion(success)
                return
            }
            print("Init Profile test : \(jsonDictionary)")
            print(error)
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(success)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.user.is_service_member = jsonDictionary["is_service_member"] as! Bool
                success = true
                completion(success)
            }
            
        }.resume()
    }
    
    func updateEmotionalBadge(body: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersEmtionalBadge.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = sendData
        
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
    
    func updateProfile(userInfo: [String: Any], completion: @escaping (Bool) -> Void) {
        var success: Bool = false
        guard let sendData = try? JSONSerialization.data(withJSONObject: userInfo, options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersProfile.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            completion(success)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = sendData
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("Error: error calling GET")
                completion(success)
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                completion(success)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(success)
                return
            }
            DispatchQueue.main.async { [weak self] in
                success = true
                completion(success)
            }
        }.resume()
    }
    
    func uploadProfileImages(image: UIImage, completion: @escaping (String) -> Void) {
        var uploadedProfileImageUrl: String = ""
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersProfileImage.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        let boundary = "\(UUID().uuidString)"
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("applecation/json", forHTTPHeaderField: "Accpet")
        
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
                do {
                    uploadedProfileImageUrl = jsonDictionary["profile_image"] as! String
                    completion(uploadedProfileImageUrl)
                } catch {
                    print("[uploadImages] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: 오월이 API FUNCTIONS (GET)
    func refreshingToken() {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.refresh.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.user.jwt_token?.access_token, forHTTPHeaderField: "accessToken")
        urlRequest.setValue(self.user.jwt_token?.refresh_token, forHTTPHeaderField: "refreshToken")
        
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
            
            DispatchQueue.main.async { [weak self] in
                do {
                    let authProvider = self?.user.jwt_token?.auth_provider
                    let decoder = JSONDecoder()
                    self?.user.jwt_token = try decoder.decode(User.JwtToken.self, from: data)
                    self?.user.jwt_token?.auth_provider = authProvider
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func lookupProfile(completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersProfile.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            
            DispatchQueue.main.async { [weak self] in
                do {
                    let decoder = JSONDecoder()
                    self?.user.member_profile = try decoder.decode(User.Profile.self, from: data)
                    completion()
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func lookupUnmodifiableColor(completion: @escaping ([String: Any]) -> Void) {
        var usedColorList: [String: Any] = [:]
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersColors.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            DispatchQueue.main.async { [weak self] in
                do {
                    usedColorList = jsonDictionary
                    completion(usedColorList)
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func getDummyData() {
        let url = URL(string: "http://13.124.20.243/api/v1/tests")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            DispatchQueue.main.async { [weak self] in
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
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.members.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (self.user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(self.user.member_id, forHTTPHeaderField: "member_id")
        
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
        }.resume()
    }
}
