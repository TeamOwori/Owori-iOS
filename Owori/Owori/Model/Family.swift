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
    
    init(family_group_name: String, invite_code: String, url: String, member_profiles: [MemberProfile], family_images: [String], family_saying: [Saying], dday_schedules: [Schedule]) {
        self.family_group_name = family_group_name
        self.invite_code = invite_code
        self.url = url
        self.member_profiles = member_profiles
        self.family_images = family_images
        self.family_sayings = family_saying
        self.dday_schedules = dday_schedules
    }
    
    struct MemberProfile: Hashable, Codable, Identifiable {
        var id: String?
        var nickname: String?
        var profile_image: String?
        var emotional_badge: String?
        
        init() {
            self.id = ""
            self.nickname = ""
            self.profile_image = ""
            self.emotional_badge = ""
        }
        
        init(id: String, nick_name: String, profile_image: String, emotional_badge: String) {
            self.id = id
            self.nickname = nick_name
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
        var schedule_id: String?
        var title: String?
        var content: String?
        var start_date: String?
        var end_date: String?
        var schedule_type: String?
        var nickname: String?
        var color: String?
        var alarm_option: [String]?
        var dday_option: Bool?
        var dday: String?
        var is_mine: Bool?
        
        init() {
            self.id = ""
            self.schedule_id = ""
            self.title = ""
            self.content = ""
            self.start_date = ""
            self.end_date = ""
            self.schedule_type = ""
            self.nickname = ""
            self.color = ""
            self.alarm_option = []
            self.dday_option = true
            self.dday = ""
            self.is_mine = false
        }
        
        init(id: String? = nil, schedule_id: String? = nil, title: String? = nil, content: String? = nil, start_datd: String? = nil, end_date: String? = nil, schedule_type: String? = nil, nickname: String? = nil, color: String? = nil, alarm_option: [String]? = nil, dday_option: Bool? = nil, dday: String? = nil, is_mine: Bool? = nil) {
            self.id = id
            self.schedule_id = schedule_id
            self.title = title
            self.content = content
            self.start_date = start_datd
            self.end_date = end_date
            self.schedule_type = schedule_type
            self.nickname = nickname
            self.color = color
            self.alarm_option = alarm_option
            self.dday_option = dday_option
            self.dday = dday
            self.is_mine = false
        }
    }
    
}
