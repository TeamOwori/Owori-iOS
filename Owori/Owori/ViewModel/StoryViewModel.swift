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
    static let host = "13.124.20.243"
    
    enum Path: String {
        case stories = "/api/v1/stories"
        case storiesUpdate = "/api/v1/stories/update"
        case storiesSortLastViewed = "/api/v1/stories?sort=created_at&last_viewed="
        case storiesFindSortStartDate = "/api/v1/stories/find"
        case images = "/api/v1/images"
        case hearts = "/api/v1/hearts"
    }
}

class StoryViewModel: ObservableObject {
    // MARK: Story 관련 PROPERTIES
    @Published var storyModel: Story = Story()
    @Published var testStoryId: String = ""
    
    // MARK: Story API FUNCTIONS (POST)
    func createStory(user: User, storyInfo: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: storyInfo, options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
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
                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    self?.testStoryId = jsonDictionary["story_id"] as! String
                    completion()
                } catch {
                    print("[createStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func createStoryInfoToDictionary(startDate: Date, endDate: Date, title: String, content: String, storyImages: [String]) -> [String: Any] {
        var storyInfoDictionary: [String: Any] = ["start_date": "\(startDate.formatDateToString(format: "yyyyMMdd"))",
                                                  "end_date": "\(endDate.formatDateToString(format: "yyyyMMdd"))",
                                                  "title": "\(title)",
                                                  "content": "\(content)",
                                                  "story_images": storyImages]
        print("createStoryInfoToDictionary : \(storyInfoDictionary)")
        return storyInfoDictionary
        
    }
    
    func createStoryInfoToUpdateDictionary(storyId: String, startDate: Date, endDate: Date, title: String, content: String, storyImages: [String]) -> [String: Any] {
        var storyInfoDictionary: [String: Any] = ["story_id": "\(storyId)",
                                                  "start_date": "\(startDate.formatDateToString(format: "yyyyMMdd"))",
                                                  "end_date": "\(endDate.formatDateToString(format: "yyyyMMdd"))",
                                                  "title": "\(title)",
                                                  "content": "\(content)",
                                                  "story_images": storyImages]
        print("createStoryInfoToDictionary : \(storyInfoDictionary)")
        return storyInfoDictionary
        
    }
    
    func toggleHeart(user: User, storyId: String, completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["story_id": storyId], options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.hearts.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
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
            
            DispatchQueue.main.async { [weak self] in
                do {
                    completion()
                } catch {
                    print("[toggleHeart] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func updateStory(user: User, storyInfo: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: storyInfo, options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.storiesUpdate.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
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
                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                        print("Error: convert failed json to dictionary")
                        return
                    }
                    completion()
                    
                } catch {
                    print("[updateStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func uploadStoryImages(user: User, images: [UIImage], completion: @escaping ([String]) -> Void) {
        var uploadedStoryImagesUrl: [String] = []
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.images.rawValue
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
        for (index, image) in images.enumerated() {
            let imageName = "image\(index + 1).jpeg"
            if let boundaryPrefix = "--\(boundary)\r\n".data(using: .utf8),
               let dispositionData = "Content-Disposition: form-data; name=\"story_images\"; filename=\"\(imageName)\"\r\n".data(using: .utf8),
               let contentTypeData = "Content-Type: image/jpg\r\n\r\n".data(using: .utf8),
               let imageData = image.jpegData(compressionQuality: 0.5),
               let lineBreakData = "\r\n".data(using: .utf8) {
                body.append(boundaryPrefix)
                body.append(dispositionData)
                body.append(contentTypeData)
                body.append(imageData)
                body.append(lineBreakData)
            }
        }
        
        if let boundaryEndData = "--\(boundary)--\r\n".data(using: .utf8) {
            body.append(boundaryEndData)
        }
        urlRequest.httpBody = body
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print(data)
            print(response)
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
                    uploadedStoryImagesUrl = jsonDictionary["story_images"] as! [String]
                    completion(uploadedStoryImagesUrl)
                } catch {
                    print("[uploadImages] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: Story API FUNCTIONS (GET)
    func lookUpStory(user: User, completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue
        urlComponents.queryItems = [
            //            URLQueryItem(name: "sort", value: "created_at"),
            //            URLQueryItem(name: "last_viewed", value: "yyyy-MM-dd".stringFromDate())
        ]
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
                    self?.storyModel = try decoder.decode(Story.self, from: data)
                    completion()
                } catch {
                    print("[lookUPStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func lookUpStorySortByStartDate(user: User, completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.storiesFindSortStartDate.rawValue
        urlComponents.queryItems = [
            URLQueryItem(name: "sort", value: "start_date"),
            //            URLQueryItem(name: "last_viewed", value: "yyyy-MM-dd".stringFromDate())
        ]
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
                    self?.storyModel = try decoder.decode(Story.self, from: data)
                    completion()
                } catch {
                    print("[lookUpStorySortByStartDate] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func getStories() -> [Story.StoryInfo] {
        return self.storyModel.stories
    }
    
    func getStoriesForCollection() -> [String: [Story.StoryInfo]] {
        var storiesByYearAndMonth: [String: [Story.StoryInfo]] = [:]
        for story in self.storyModel.stories {
            if let startDate = story.start_date {
                let yearStartIndex = startDate.index(startDate.startIndex, offsetBy: 0)
                let yearEndIndex = startDate.index(startDate.startIndex, offsetBy: 3)
                let year = startDate[yearStartIndex...yearEndIndex]
                let monthStartIndex = startDate.index(startDate.startIndex, offsetBy: 4)
                let monthEndIndex = startDate.index(startDate.startIndex, offsetBy: 5)
                let month = startDate[monthStartIndex...monthEndIndex]
                let yearAndMonth = "\(year)-\(month)"
                
                if storiesByYearAndMonth[yearAndMonth] == nil {
                    storiesByYearAndMonth[yearAndMonth] = []
                }
                storiesByYearAndMonth[yearAndMonth]?.append(story)
            }
        }
        return storiesByYearAndMonth
    }
    
    func lookUpStoryDetail(user: User, storyId: String, completion: @escaping (Story.StoryInfo) -> Void) {
        var storyInfo: Story.StoryInfo = Story.StoryInfo()
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue + "/" + storyId
        
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
                    if let storyIndex = self?.storyModel.stories.firstIndex(where: { $0.story_id == storyId }) {
                        self?.storyModel.stories[storyIndex] = try decoder.decode(Story.StoryInfo.self, from: data)
                        storyInfo = (self?.storyModel.stories[storyIndex])!
                        completion(storyInfo)
                    } else {
                        print("파싱 에러")
                    }
                } catch {
                    print("[lookUpStoryDetail] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func deleteStory(user: User, storyId: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.stories.rawValue + "/" + storyId
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        
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
            DispatchQueue.main.async { [weak self] in
                do {
                    if let index = self?.storyModel.stories.firstIndex(where: { $0.story_id == storyId }) {
                        self?.storyModel.stories.remove(at: index)
                        print("Story removed successfully")
                    } else {
                        print("Story not found")
                    }
                    completion()
                } catch {
                    print("[createStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func searchStoryByStoryId(story_id: String) -> Story.StoryInfo? {
        if let storyInfo = storyModel.stories.first(where: { $0.story_id == story_id }) {
            return storyInfo
        } else {
            print("찾는 스토리가 없습니다. (storyId가 존재하지 않습니다.)")
            return nil
        }
    }
}
