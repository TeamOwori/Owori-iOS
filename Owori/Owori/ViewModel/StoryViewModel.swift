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
        print("스토리 인포 로그 : \(storyInfo)")
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
                    print("[create Story Log]: \(self?.storyModel)")
                    // 임시
                    print(self?.testStoryId)
                    completion()
                } catch {
                    print("[createStory] Error: Failed to parse JSON data - \(error)")
                }
            }
            //            print("[Create Story Log]: \(jsonDictionary)")
        }.resume()
    }
    
    func createStoryInfoToDictionary(startDate: Date, endDate: Date, title: String, content: String, storyImages: [String]) -> [String: Any] {
        var storyInfoDictionary: [String: Any] = ["start_date": "\(startDate.formatDateToString(format: "yyyyMMdd"))",
                                                  "end_date": "\(endDate.formatDateToString(format: "yyyyMMdd"))",
                                                  "title": "\(title)",
                                                  "content": "\(content)",
                                                  // image 임시 데이터 추가 해야함.
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
                                                  // image 임시 데이터 추가 해야함.
                                                  "story_images": storyImages]
        print("createStoryInfoToDictionary : \(storyInfoDictionary)")
        return storyInfoDictionary
        
    }
    
    func toggleHeart(user: User, storyId: String, completion: @escaping () -> Void) {
        
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["story_id": storyId], options: []) else { return }
        
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.hearts.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/hearts/\(storyId)")!
        
        // url 테스트 log
        print("[toggleHeart url Log] : \(url)")
        
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
            
            
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
//                    guard let index = self?.storyModel.stories.firstIndex(where: { $0.story_id == storyId }) else {
//                        print("찿는 스토리가 없습니다.")
//                        return
//                    }
//                    
//                    let decoder = JSONDecoder()
//                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
//                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
//                        print("Error: convert failed json to dictionary")
//                        return
//                    }
//                    print(jsonDictionary)
//                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("[toggle Heart Log]: \(self?.storyModel)")
                    completion()
                } catch {
                    print("[toggleHeart] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func updateStory(user: User, storyInfo: [String: Any], completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: storyInfo, options: []) else { return }
        
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
                    print("[updateStory] jsonDictionary story_id : \(jsonDictionary)")
                    //                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("[Story Model Log]: \(self?.storyModel)")
                    completion()
                    
                } catch {
                    print("[updateStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    //    func isJPEG(data: Data) -> Bool {
    //        return data.count >= 2 && data[0] == 0xFF && data[1] == 0xD8
    //    }
    //
    //    func isPNG(data: Data) -> Bool {
    //        return data.count >= 8 && data[0] == 0x89 && data[1] == 0x50 && data[2] == 0x4E && data[3] == 0x47 && data[4] == 0x0D && data[5] == 0x0A && data[6] == 0x1A && data[7] == 0x0A
    //    }
    
    
    
    
    func uploadStoryImages(user: User, images: [UIImage], completion: @escaping ([String]) -> Void) {
        var uploadedStoryImagesUrl: [String] = []
        
        // 이미지 로그 테스트
        print("이미지 로그 테스트 : \(images)")
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.images.rawValue
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
        
        for (index, image) in images.enumerated() {
            let imageName = "image\(index + 1).png"
            
            
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
        
        // 요청
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
                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    //                    let decoder = JSONDecoder()
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    
                    
                    print(jsonDictionary)
                    print("성공")
                    uploadedStoryImagesUrl = jsonDictionary["story_images"] as! [String]
                    completion(uploadedStoryImagesUrl)
                    //                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("[Story Model Log]: \(self?.storyModel)")
                    
                } catch {
                    print("[uploadImages] Error: Failed to parse JSON data - \(error)")
                }
            }
            
        }.resume()
        
    }
    
    // MARK: Story API FUNCTIONS (GET)
    
    // 파라미터로 쿼리값 조절해서 스토리 조회 순서 변경할 수 있을 것 같음.
    func lookUpStory(user: User, completion: @escaping () -> Void) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
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
        
        // url 테스트 log
        print("[lookUpStory url Log] : \(url)")
        
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
                    print("[lookUpStory Story Model Log]: \(String(describing: self?.storyModel))")
                    completion()
                } catch {
                    print("[lookUPStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // 임시
    func lookUpStorySortByStartDate(user: User, completion: @escaping () -> Void) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
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
        
        // url 테스트 log
        print("[lookUpStorySortByStartDate url Log] : \(url)")
        
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
                    print("[lookUpStorySortByStartDate Story Model Log]: \(String(describing: self?.storyModel))")
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
        print("DDDDDD\(self.storyModel.stories)")
        
        // "년-월"별로 스토리를 묶을 딕셔너리
        var storiesByYearAndMonth: [String: [Story.StoryInfo]] = [:]
        
        // stories 배열을 돌면서 월 별로 묶고 딕셔너리 형태로 월을 표시해서 저장
        for story in self.storyModel.stories {
            if let startDate = story.start_date {
                //                let components = startDate.components(separatedBy: "-")
                
                let yearStartIndex = startDate.index(startDate.startIndex, offsetBy: 0)
                let yearEndIndex = startDate.index(startDate.startIndex, offsetBy: 3)
                let year = startDate[yearStartIndex...yearEndIndex]
                
                let monthStartIndex = startDate.index(startDate.startIndex, offsetBy: 4)
                let monthEndIndex = startDate.index(startDate.startIndex, offsetBy: 5)
                let month = startDate[monthStartIndex...monthEndIndex]
                
                print(year)
                print(month)
                
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
                        print("[lookUp Story Detail Log]: \(String(describing: self?.storyModel.stories[storyIndex]))")
                        storyInfo = (self?.storyModel.stories[storyIndex])!
                        completion(storyInfo)
                    } else {
                        print("파싱 에러")
                    }
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    
                } catch {
                    print("[lookUpStoryDetail] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
        
    }
    
    func deleteStory(user: User, storyId: String, completion: @escaping () -> Void) {
        print("스토리 id : \(storyId)")
        
        
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
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/stories")!
        
        // url 테스트 log
        print("[deleteStory url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        //        urlRequest.httpBody = sendData
        
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
            
            //            print(jsonDictionary)
            print(data)
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            //            // Story를 @Published로 선언했기 때문에 background thread에서 main thread로 업데이트를 전달해야 한다.
            //            // 그래서 DispatchQueue.main.async 사용.
            DispatchQueue.main.async { [weak self] in
                //                // JSON 데이터를 파싱하여 User 구조체에 할당
                do {
                    //                    let decoder = JSONDecoder()
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    //                    // 임시
                    //                    self?.testStoryId = jsonDictionary["story_id"] as! String
                    //
                    //                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("[create Story Log]: \(self?.storyModel)")
                    //                    // 임시
                    //                    print(self?.testStoryId)
                    //                    self?.storyModel.stories.first(where: { $0.story_id == storyId })
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
            //            //            print("[Create Story Log]: \(jsonDictionary)")
        }.resume()
    }
    
    //    func deleteStoryOnClient(storyId: String) {
    //        if let index = self.storyModel.stories.firstIndex(where: { $0.story_id == storyId }) {
    //            self.storyModel.stories.remove(at: index)
    //            print("Story removed successfully")
    //        } else {
    //            print("Story not found")
    //        }
    //    }
    
    func searchStoryByStoryId(story_id: String) -> Story.StoryInfo? {
        
        if let storyInfo = storyModel.stories.first(where: { $0.story_id == story_id }) {
            return storyInfo
        } else {
            print("찾는 스토리가 없습니다. (storyId가 존재하지 않습니다.)")
            return nil
        }
        
    }
}
