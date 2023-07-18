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
}
