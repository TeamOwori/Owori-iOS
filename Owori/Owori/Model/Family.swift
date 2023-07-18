//
//  Family.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/19.
//

import Foundation

struct Family: Codable {
    var family_group_name: String?
    var invite_code: String?
    var url: String?
    var member_profiles: [MemberProfile]?
    var family_images: [String]?
    var family_sayings: [Saying]?
    var dday_schedules: [Schedule]?
    
    init() {
        self.family_group_name = ""
        self.invite_code = ""
        self.url = ""
    }
    
    init(family_group_name: String, invite_code: String, url: String) {
        self.family_group_name = family_group_name
        self.invite_code = invite_code
        self.url = url
    }
    
    struct MemberProfile: Codable {
        var id: String?
        var nick_name: String?
        var profile_image: String?
        var emotional_badge: String?
        
        init() {
            self.id = ""
            self.nick_name = ""
            self.profile_image = ""
            self.emotional_badge = ""
        }
        
        init(id: String, nick_name: String, profile_image: String, emotional_badge: String) {
            self.id = id
            self.nick_name = nick_name
            self.profile_image = profile_image
            self.emotional_badge = emotional_badge
        }
    }
    
    struct Saying: Codable {
        var id: String?
        var content: String?
        var member_id: String?
        var tag_members_id: [String]?
        var updated_at: String?
        
        init() {
            self.id = ""
            self.content = ""
            self.member_id = ""
            self.tag_members_id = []
            self.updated_at = ""
        }
        
        init(id: String, content: String, member_id: String, tag_members_id: [String], updated_at: String) {
            self.id = id
            self.content = content
            self.member_id = member_id
            self.tag_members_id = tag_members_id
            self.updated_at = updated_at
        }
    }
    
    struct Schedule: Codable {
        var id: String?
        var title: String?
        var start_datd: String?
        var end_date: String?
        var schedule_type: String?
        var member_nickname: String?
        var color: String?
        var alarm_option: [String]?
        var dday_option: Bool?
        var dday: String?
        
        init() {
            self.id = ""
            self.title = ""
            self.start_datd = ""
            self.end_date = ""
            self.schedule_type = ""
            self.member_nickname = ""
            self.color = ""
            self.alarm_option = []
            self.dday_option = true
            self.dday = ""
        }
        
        // 기본 init을 이렇게 제공해주는데... 이게 맞는지 위에가 맞는지 모르겠음... 좀 더 확인해보고 모델 init들 통일해야 함.
        init(id: String? = nil, title: String? = nil, start_datd: String? = nil, end_date: String? = nil, schedule_type: String? = nil, member_nickname: String? = nil, color: String? = nil, alarm_option: [String]? = nil, dday_option: Bool? = nil, dday: String? = nil) {
            self.id = id
            self.title = title
            self.start_datd = start_datd
            self.end_date = end_date
            self.schedule_type = schedule_type
            self.member_nickname = member_nickname
            self.color = color
            self.alarm_option = alarm_option
            self.dday_option = dday_option
            self.dday = dday
        }
    }
    
}
