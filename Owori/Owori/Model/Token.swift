//
//  Token.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/14.
//

import Foundation

struct Token: Codable {
    var authProvider: String
    var accessToken: String
    var refreshToken: String
    
    init() {
        self.authProvider = ""
        self.accessToken = ""
        self.refreshToken = ""
    }
    
    init(authProvider: String, accessToken: String, refreshToken: String) {
        self.authProvider = authProvider
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
