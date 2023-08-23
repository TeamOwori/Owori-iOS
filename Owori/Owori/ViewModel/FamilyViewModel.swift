//
//  FamilyViewModel.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/19.
//

import SwiftUI

fileprivate enum OworiAPI {
    static let scheme = "http"
    static let host = "13.124.20.243"
    
    enum Path: String {
        case families = "/api/v1/families"
        case familiesMember = "/api/v1/families/members"
        case familiesGroupName = "/api/v1/families/group-name"
        case membersHome = "/api/v1/members/home"
        case familiesCode = "/api/v1/families/code"
        case familiesImages = "/api/v1/families/images"
        case schedule = "/api/v1/schedule"
        case scheduleUpdate = "/api/v1/schedule/update"
    }
}

class FamilyViewModel: ObservableObject {
    @Published var family: Family = Family()
    
    
    func getFamily() -> Family {
        return self.family
    }
    
    // MARK: 오월이 API FUNCTIONS (Post)
    
    // 가족 생성
    func createFamily(user: User, family_group_name: String, completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["family_group_name": family_group_name], options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
                var urlComponents = URLComponents()
                urlComponents.scheme = OworiAPI.scheme
                urlComponents.host = OworiAPI.host
                urlComponents.path = OworiAPI.Path.families.rawValue
                guard let url = urlComponents.url else {
                    print("Error: cannot create URL")
                    return
                }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
//        let url = URL(string: "http://localhost:8080/api/v1/families")!
        
        // url 테스트 log
        print("[joinMember url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
                    let decoder = JSONDecoder()
                    self?.family = try decoder.decode(Family.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Family: \(String(describing: self?.family))")
                    self?.family.invite_code = jsonDictionary["invite_code"] as? String
                    completion()
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // 가족 멤버 초대코드로 추가
    func addFamilyMemberInviteCode(user: User, invite_code: String, completion: @escaping (Bool) -> Void) {
        var success: Bool = false
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["invite_code": invite_code], options: []) else { return }
        
        print(invite_code)
        print(self.family.invite_code)
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
                var urlComponents = URLComponents()
                urlComponents.scheme = OworiAPI.scheme
                urlComponents.host = OworiAPI.host
                urlComponents.path = OworiAPI.Path.familiesMember.rawValue
                guard let url = urlComponents.url else {
                    print("Error: cannot create URL")
                    completion(success)
                    return
                }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
//        let url = URL(string: "http://localhost:8080/api/v1/families")!
        
        // url 테스트 log
        print("[joinMember url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = sendData
        
        // 요청
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
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(success)
                return
            }
            
            print("가족 연결 성공")
            success = true
            completion(success)
            
        }.resume()
    }
    
    // 가족 그룹 이름 수정
    func changeFamilyName(user: User, family_group_name: String, completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["family_group_name": family_group_name], options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
                var urlComponents = URLComponents()
                urlComponents.scheme = OworiAPI.scheme
                urlComponents.host = OworiAPI.host
                urlComponents.path = OworiAPI.Path.familiesGroupName.rawValue
                guard let url = urlComponents.url else {
                    print("Error: cannot create URL")
                    return
                }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
//        let url = URL(string: "http://localhost:8080/api/v1/families/group-name")!
        
        // url 테스트 log
        print("[changeFamilyName url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
            
            DispatchQueue.main.async { [weak self] in
                self?.family.family_group_name = family_group_name
                
                completion()
                
            }
            
        }.resume()
    }
    
    func uploadFamilyImage(user: User, image: UIImage, completion: @escaping (String) -> Void) {
        var uploadedProfileImageUrl: String = ""
        
        // 이미지 로그 테스트
        print("이미지 로그 테스트 : \(image)")
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesImages.rawValue
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
        
        
        let imageName = "familyImage.jpeg"
        
        
        if let boundaryPrefix = "--\(boundary)\r\n".data(using: .utf8),
           let dispositionData = "Content-Disposition: form-data; name=\"family_image\"; filename=\"\(imageName)\"\r\n".data(using: .utf8),
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
                    let decoder = JSONDecoder()
                    self?.family.family_images!.append(jsonDictionary["family_image"] as! String)
                    
                    
                    print(jsonDictionary)
                    print("성공")
                    
                    uploadedProfileImageUrl = jsonDictionary["family_image"] as! String
                    completion(uploadedProfileImageUrl)
                    //                    self?.storyModel.stories[index].is_liked = jsonDictionary["is_liked"] as! Bool
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    //                    print("[Story Model Log]: \(self?.storyModel)")
                    
                } catch {
                    print("[uploadFamilyImages] Error: Failed to parse JSON data - \(error)")
                }
            }
            
        }.resume()
        
    }
    
    func createSchedule(user: User, schduleInfo: [String: Any], completion: @escaping (String) -> Void) {
        var scheduleId: String = ""
        guard let sendData = try? JSONSerialization.data(withJSONObject: schduleInfo, options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.schedule.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/stories/update\(storyId)")!
        
        // url 테스트 log
        print("[createSchedule url Log] : \(url)")
        
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
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                        print("Error: convert failed json to dictionary")
                        return
                    }
                    print("[createSchedule] jsonDictionary story_id : \(jsonDictionary)")
                    
//                    self?.family.dday_schedules.append(jsonDictionary[]) = try decoder.decode(Family.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
//                    print("Family: \(String(describing: self?.family))")
                    
                    
                    
                    completion(scheduleId)
                    
                } catch {
                    print("[updateStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func updateSchedule(user: User, schduleInfo: [String: Any], completion: @escaping (String) -> Void) {
        var scheduleId: String = ""
        guard let sendData = try? JSONSerialization.data(withJSONObject: schduleInfo, options: []) else { return }
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.scheduleUpdate.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
        //        let url = URL(string: "http://localhost:8080/api/v1/stories/update\(storyId)")!
        
        // url 테스트 log
        print("[updateSchedule url Log] : \(url)")
        
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
                    //                    self?.storyModel.stories.append(try decoder.decode(Story.StoryInfo.self, from: data))
                    guard let jsonDictionary = try? JSONSerialization.jsonObject(with: Data(data), options: []) as? [String: Any] else {
                        print("Error: convert failed json to dictionary")
                        return
                    }
                    print("[createSchedule] jsonDictionary story_id : \(jsonDictionary)")
                    
//                    self?.family.dday_schedules.append(jsonDictionary[]) = try decoder.decode(Family.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
//                    print("Family: \(String(describing: self?.family))")
                    
                    
                    
                    completion(scheduleId)
                    
                } catch {
                    print("[updateStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    
    
    
    // MARK: DELETE
    func deleteFamilyImage(user: User, imageURL: String, completion: @escaping () -> Void) {
        print("스토리 id : \(imageURL)")
        
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["family_image": imageURL], options: []) else { return }
        
        
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesImages.rawValue
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
                    if let index = self?.family.family_images?.firstIndex(where: { $0 == imageURL }) {
                        self?.family.family_images?.remove(at: index)
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
    
    func deleteFamilySchedule(user: User, scheduleId: String, completion: @escaping () -> Void) {
        print("스토리 id : \(scheduleId)")
        
//        guard let sendData = try? JSONSerialization.data(withJSONObject: ["schedule_id": scheduleId], options: []) else { return }
        
        
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.schedule.rawValue + "/" + scheduleId
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
                    if let index = self?.family.family_images?.firstIndex(where: { $0 == scheduleId }) {
                        self?.family.family_images?.remove(at: index)
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
    
    // MARK: 오월이 API FUNCTIONS (GET)
    func lookUpHomeView(user: User, completion: @escaping () -> Void) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
                var urlComponents = URLComponents()
                urlComponents.scheme = OworiAPI.scheme
                urlComponents.host = OworiAPI.host
                urlComponents.path = OworiAPI.Path.membersHome.rawValue
                guard let url = urlComponents.url else {
                    print("Error: cannot create URL")
                    return
                }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
//        let url = URL(string: "http://localhost:8080/api/v1/members/home")!
        
        // url 테스트 log
        print("[Lookup Family Info url Log] : \(url)")
        
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
            
            print(data)
            print(response)
            print("[lookUpHomeView]: \(jsonDictionary)")
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
                    self?.family = try decoder.decode(Family.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Family: \(String(describing: self?.family))")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
                completion()
            }
        }.resume()
    }
    
    // 가족 멤버 초대코드 재생성
    func regenInvitecode(user: User) {
        
        // 요청을 보낼 API의 url 설정
        // 배포 후 url 설정
                var urlComponents = URLComponents()
                urlComponents.scheme = OworiAPI.scheme
                urlComponents.host = OworiAPI.host
                urlComponents.path = OworiAPI.Path.familiesCode.rawValue
                guard let url = urlComponents.url else {
                    print("Error: cannot create URL")
                    return
                }
        
        // 배포 이전 고정 url 설정 (추후 삭제 예정)
//        let url = URL(string: "http://localhost:8080/api/v1/families/code")!
        
        // url 테스트 log
        print("[regenInvitecode url Log] : \(url)")
        
        // urlRequeset에 함께 담을 header, body 설정
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        
        
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
                    self?.family.invite_code = jsonDictionary["invite_code"] as? String
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Family: \(String(describing: self?.family))")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
}
