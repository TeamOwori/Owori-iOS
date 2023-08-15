//
//  FamilyViewModel.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/19.
//

import Foundation

fileprivate enum OworiAPI {
    static let scheme = "http"
    static let host = "owori.store"
    
    enum Path: String {
        case families = "/api/v1/families"
        case familiesMember = "/api/v1/families/members"
        case familiesGroupName = "/api/v1/families/group-name"
        case membersHome = "/api/v1/members/home"
        case familiesCode = "/api/v1/families/code"
    }
}

class FamilyViewModel: ObservableObject {
    @Published var family: Family = Family()
    
    func getFamily() -> Family {
        return self.family
    }
    
    // MARK: 오월이 API FUNCTIONS (Post)
    
    // 가족 생성
    func createMember(user: User, family_group_name: String, completion: @escaping () -> Void) {
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
                    completion()
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
    // 가족 멤버 초대코드로 추가
    func addFamilyMemberInviteCode(user: User, invite_code: String) {
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
            print(response)
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
        }.resume()
    }
    
    // 가족 그룹 이름 수정
    func changeFamilyName(user: User, family_group_name: String) {
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
                    self?.family = try decoder.decode(Family.self, from: data)
                    
                    // User 구조체에 할당된 데이터 사용 (테스트 log)
                    print("Family: \(String(describing: self?.family))")
                } catch {
                    print("Error: Failed to parse JSON data - \(error)")
                }
            }
        }.resume()
    }
    
}
