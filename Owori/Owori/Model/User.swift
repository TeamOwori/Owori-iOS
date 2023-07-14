//
//  User.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/14.
//

import Foundation


struct User: Codable {
    var member_id: String?
    var jwt_token: JwtToken?
    
    init() {
        self.member_id = ""
        self.jwt_token = JwtToken()
    }
    
    init(member_id: String, jwt_token: JwtToken) {
        self.member_id = member_id
        self.jwt_token = jwt_token
    }
    
    struct JwtToken: Codable {
        var access_token: String?
        var refresh_token: String?
        var auth_provider: String?
    
        init() {
            self.access_token = ""
            self.refresh_token = ""
        }
        
        init(access_token: String, refresh_token: String) {
            self.access_token = access_token
            self.refresh_token = refresh_token
        }
    }
}
