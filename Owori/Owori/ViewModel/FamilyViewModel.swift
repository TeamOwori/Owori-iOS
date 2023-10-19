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
    func createFamily(user: User, family_group_name: String, completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["family_group_name": family_group_name], options: []) else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.families.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
                    self?.family = try decoder.decode(Family.self, from: data)
                    self?.family.invite_code = jsonDictionary["invite_code"] as? String
                    completion()
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func addFamilyMemberInviteCode(user: User, invite_code: String, completion: @escaping (Bool) -> Void) {
        var success: Bool = false
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["invite_code": invite_code], options: []) else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesMember.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            completion(success)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
            success = true
            completion(success)
        }.resume()
    }
    
    func changeFamilyName(user: User, family_group_name: String, completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["family_group_name": family_group_name], options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesGroupName.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
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
                self?.family.family_group_name = family_group_name
                completion()
            }
        }.resume()
    }
    
    func uploadFamilyImage(user: User, image: UIImage, completion: @escaping (String) -> Void) {
        var uploadedProfileImageUrl: String = ""
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesImages.rawValue
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
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                do {
                    let decoder = JSONDecoder()
                    self?.family.family_images!.append(jsonDictionary["family_image"] as! String)
                    uploadedProfileImageUrl = jsonDictionary["family_image"] as! String
                    completion(uploadedProfileImageUrl)
                } catch {
                    print("[uploadFamilyImages] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    func createSchedule(user: User, schduleInfo: [String: Any], completion: @escaping (String) -> Void) {
        var scheduleId: String = ""
        guard let sendData = try? JSONSerialization.data(withJSONObject: schduleInfo, options: []) else { return }
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.schedule.rawValue
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
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.scheduleUpdate.rawValue
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
                    completion(scheduleId)
                } catch {
                    print("[updateStory] Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: DELETE
    func deleteFamilyImage(user: User, imageURL: String, completion: @escaping () -> Void) {
        guard let sendData = try? JSONSerialization.data(withJSONObject: ["family_image": imageURL], options: []) else { return }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesImages.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
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
        }.resume()
    }
    
    func deleteFamilySchedule(user: User, scheduleId: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.schedule.rawValue + "/" + scheduleId
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
        }.resume()
    }
    
    // MARK: 오월이 API FUNCTIONS (GET)
    func lookUpHomeView(user: User, completion: @escaping () -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.membersHome.rawValue
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
                    self?.family = try decoder.decode(Family.self, from: data)
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
                completion()
            }
        }.resume()
    }
    
    func regenInvitecode(user: User) {
        var urlComponents = URLComponents()
        urlComponents.scheme = OworiAPI.scheme
        urlComponents.host = OworiAPI.host
        urlComponents.path = OworiAPI.Path.familiesCode.rawValue
        guard let url = urlComponents.url else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(user.member_id, forHTTPHeaderField: "member_id")
        urlRequest.setValue("Bearer " + (user.jwt_token?.access_token)!, forHTTPHeaderField: "Authorization")
        
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
                    self?.family.invite_code = jsonDictionary["invite_code"] as? String
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
}
