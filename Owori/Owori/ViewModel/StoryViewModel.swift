//
//  StoryViewModel.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/14.
//

import SwiftUI
import Foundation

fileprivate enum OworiAPI {
    static let scheme = "http"
    static let host = "owori.store"
    
    enum Path: String {
        case stories = "/api/v1/stories"
        case storiesUpdate = "/api/v1/stories/update"
        case storiesSortLastViewed = "/api/v1/stories?sort=created_at&last_viewed="
    }
}

class StoryViewModel: ObservableObject {
    
    // MARK: Story 관련 PROPERTIES
    @Published var storyModel: Story = Story()
    @Published var testStoryId: String = ""
    
    // MARK: Story API FUNCTIONS (POST)
    func createStory(user: User, storyInfo: [String: Any]) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: storyInfo, options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/stories")!
        
        // url 테스트 log
        print("[createStory url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
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
            
            print(jsonDictionary)
            print(data)
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    // 임시
                    self?.testStoryId = jsonDictionary["story_id"] as! String
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("[Story Model Log]: \(self?.storyModel)")
                    // 임시
                    print(self?.testStoryId)
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
            //            print("[Create Story Log]: \(jsonDictionary)")
        }.resume()
    }
    
    func toggleHeart(user: User, storyId: String) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.storiesUpdate.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/hearts/\(storyId)")!
        
        // url 테스트 log
        print("[createStory url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
            
            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    guard let index = self?.storyModel.stories.firstIndex(where: { $0.story_id == storyId }) else {
                        print("찿는 스토리가 없습니다.")
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                        print("Error: convert failed json to dictionary")
                        return
                    }
                    print(jsonDictionary)
                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("[Story Model Log]: \(self?.storyModel)")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func updateStory(user: User, storyInfo: [String: Any]) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.storiesUpdate.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/stories/update\(storyId)")!
        
        // url 테스트 log
        print("[updateStory url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
            
            print(self.testStoryId)
            print(jsonDictionary)
            print(data)
            print(response)
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                        print("Error: convert failed json to dictionary")
                        return
                    }
                    print("jsonDictionary story_id : \(jsonDictionary)")
                    //                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("[Story Model Log]: \(self?.storyModel)")
                    
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: Story API FUNCTIONS (GET)
    func lookUpStoryLatestOrder(user: User) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue
        urlComponents.queryItems = [
            URLQueryItem(name: "sort", value: "created_at"),
            URLQueryItem(name: "last_viewed", value: "yyyy-MM-dd".stringFromDate())
            
        ]
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // url 테스트 log
        print("[lookUpStoryLatestOrder url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
            print(data)
            print(response)
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    self?.storyModel = try decoder.decode(Story.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("[Story Model Log]: \(String(describing: self?.storyModel))")
                    
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
            
        }.resume()
    }
    
    func lookUpStoryDetail(user: User, storyId: String, completion: @escaping () -> Void) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue + "/" + storyId
        
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // url 테스트 log
        print("[lookUpStoryDetail url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
            print(data)
            print(response)
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    let decoder = JSONDecoder()
                    if let storyIndex = self?.storyModel.stories.firstIndex(where: { $0.story_id == storyId }) {
                        self?.storyModel.stories[storyIndex] = try decoder.decode(Story.StoryInfo.self, from: data)
                        print("[Story Model Detail Log]: \(String(describing: self?.storyModel.stories[storyIndex]))")
                    } else {
                        print("파싱 에러")
                    }
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
            
        }.resume()
        
    }
    
    func searchStory(story_id: String) -> Story.StoryInfo? {
        
        if let storyInfo = storyModel.stories.first(where: { $0.story_id == story_id }) {
            return storyInfo
        } else {
            print("에러")
            return nil
        }
        
    }
}
