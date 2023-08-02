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
    
    func getFamily() -> Void {
        print(self.family)
    }
    
    // MARK: 오월이 API FUNCTIONS (Post)
    
    // 가족 생성
    func createMember(user: User, family_group_name: String) {
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
    func lookUpHomeView(user: User) {
        
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
            
            //            print(jsonDictionary)
            // 테스트 데이터
//            let jsonDictionary: [String: Any] = ["family_group_name" : "오월이 가족",
//                                  "member_profiles" : [
//                                    "id" : "be90ec36-c45c-444b-a8e1-fcc3720ccfc5",
//                                    "nick_name" : "아빠",
//                                    "profile_image" : "111111",
//                                    "emotional_badge" : "SO_HAPPY"
//                                    ,
//                                    "id" : "2d49ed2a-b7eb-4cf6-ab6c-45fc4a14ed1d",
//                                    "nick_name" : "엄마",
//                                    "profile_image" : "222222",
//                                    "emotional_badge" : "JOY"
//                                    ,
//                                    "id" : "93a0f3cf-2c3c-419d-a9d9-4bb06f3b9ddc",
//                                    "nick_name" : "아들",
//                                    "profile_image" : "333333",
//                                    "emotional_badge" : "CRY"
//                                  ] ,
//                                  "family_images" : [ "111111", "222222" ],
//                                  "family_sayings" : [
//                                    "id" : "20d995d2-b2e9-434b-9d47-66aa27064341",
//                                    "content" : "오늘 회식해요",
//                                    "member_id" : "be90ec36-c45c-444b-a8e1-fcc3720ccfc5",
//                                    "tag_members_id" : [ "81d7cde9-2523-4e95-b73e-ed01cdd10e72", "05e1c207-f4e0-4499-91f0-f1290e6334c7" ],
//                                    "updated_at" : "2023-07-17T15:59:47.5558975"
//                                    ,
//                                    "id" : "c5f51c86-50d7-46f4-b760-c7c1c36ee0a7",
//                                    "content" : "오늘 저녁 카레",
//                                    "member_id" : "2d49ed2a-b7eb-4cf6-ab6c-45fc4a14ed1d",
//                                    "tag_members_id" : [ ],
//                                    "updated_at" : "2023-07-17T15:59:47.5558975"
//                                  ],
//                                  "dday_schedules" : [
//                                    "id" : "11c2e745-22be-4d30-b625-e3de64fd285b",
//                                    "title" : "가족 여행",
//                                    "start_date" : "2023-07-20",
//                                    "end_date" : "2023-07-23",
//                                    "schedule_type" : "FAMILY",
//                                    "member_nickname" : "벡스",
//                                    "color" : "BLUE",
//                                    "alarm_options" : [ ],
//                                    "dday_option" : true,
//                                    "dday" : "D-3"
//                                    ,
//                                    "id" : "f86e4a3a-d991-4bea-b20b-82815523d9a5",
//                                    "title" : "휴가",
//                                    "start_date" : "2023-07-24",
//                                    "end_date" : "2023-07-28",
//                                    "schedule_type" : "INDIVIDUAL",
//                                    "member_nickname" : "오월이",
//                                    "color" : "SKYBLUE",
//                                    "alarm_options" : [ ],
//                                    "dday_option" : true,
//                                    "dday" : "D-3"
//                                    ,
//                                    "id" : "971f64d7-f9fd-4103-8778-bca004c158f6",
//                                    "title" : "친구 여행",
//                                    "start_date" : "2023-07-30",
//                                    "end_date" : "2023-08-03",
//                                    "schedule_type" : "INDIVIDUAL",
//                                    "member_nickname" : "벡스",
//                                    "color" : "GREEN",
//                                    "alarm_options" : [ ],
//                                    "dday_option" : true,
//                                    "dday" : "D-3"
//                                  ]]
            
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
