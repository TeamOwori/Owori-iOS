//
//  User.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/14.
//

import Foundation


struct User: Codable {
    var memberId: String
    var jwtToken: OworiToken
    
    // 디코딩을 위한 열거형 추가 (디코딩 시 변수명 변경)
    enum CodingKeys: String, CodingKey {
            case memberId = "member_id"
            case jwtToken = "jwt_token"
        }
    
    init() {
        self.memberId = ""
        self.jwtToken = OworiToken()
    }
    
    init(memberId: String, jwtToken: OworiToken) {
        self.memberId = memberId
        self.jwtToken = jwtToken
    }
    
    struct OworiToken: Codable {
        var accessToken: String
        var refreshToken: String
    
        // 디코딩을 위한 열거형 추가 (디코딩 시 변수명 변경)
        enum CodingKeys: String, CodingKey {
                    case accessToken = "access_token"
                    case refreshToken = "refresh_token"
                }
        
        init() {
            self.accessToken = ""
            self.refreshToken = ""
        }
        
        init(accessToken: String, refreshToken: String) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
        }
    }
}
