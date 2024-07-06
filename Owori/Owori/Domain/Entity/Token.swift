//
//  Token.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/14.
//

import Foundation

struct Token: Codable {
    var authProvider: String?
    var accessToken: String?
    var authorizationCode: String?
    
    init() {
        self.authProvider = ""
        self.accessToken = ""
        self.authorizationCode = ""
    }
    
    init(authProvider: String, accessToken: String) {
        self.authProvider = authProvider
        self.accessToken = accessToken
        self.authorizationCode = ""
    }
    
    init(authProvider: String, accessToken: String, authorizationCode: String) {
        self.authProvider = authProvider
        self.accessToken = accessToken
        self.authorizationCode = authorizationCode
    }
}
