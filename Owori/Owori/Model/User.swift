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
    var is_service_member: Bool?
    var member_profile: Profile?
    
    init() {
        self.member_id = ""
        self.is_service_member = false
        self.jwt_token = JwtToken()
        self.member_profile = Profile()
    }
    
    init(member_id: String, jwt_token: JwtToken, is_service_member: Bool, member_profile: Profile) {
        self.member_id = member_id
        self.jwt_token = jwt_token
        self.is_service_member = is_service_member
        self.member_profile = member_profile
    }
    
    struct JwtToken: Codable {
        var access_token: String?
        var refresh_token: String?
        var auth_provider: String?
    
        init() {
            self.access_token = ""
            self.refresh_token = ""
            self.auth_provider = ""
        }
        
        init(access_token: String, refresh_token: String, auth_provider: String) {
            self.access_token = access_token
            self.refresh_token = refresh_token
            self.auth_provider = auth_provider
        }
    }
    
    struct Profile: Codable {
        var nickname: String?
        var birthday: String?
        var color: String?
        var emotional_badge: String?
        var profile_image: String?
        var story_count: Int?
        var heart_count: Int?
        
        init() {
            self.nickname = ""
            self.birthday = ""
            self.color = ""
            self.emotional_badge = ""
            self.profile_image = ""
        }
        
        init(nickname: String, birthday: String) {
            self.nickname = nickname
            self.birthday = birthday
        }
        
        init(nickname: String, birthday: String, color: String) {
            self.nickname = nickname
            self.birthday = birthday
            self.color = color
        }
        
        init(nickname: String, birthday: String, color: String, emotional_badge: String, profile_image: String, story_count: Int, heart_count: Int) {
            self.nickname = nickname
            self.birthday = birthday
            self.color = color
            self.emotional_badge = emotional_badge
            self.profile_image = profile_image
            self.story_count = story_count
            self.heart_count = heart_count
        }
    }
}
