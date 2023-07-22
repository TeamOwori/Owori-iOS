//
//  Home.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import Foundation
// 임시 모델
struct Photo: Codable {
    var photos: [PhotoInfo] = []
}

extension Photo {
    struct PhotoInfo: Codable, Identifiable {
        var id: String//?
        var name: String//?
    }
}

struct DDay: Codable {
    var ddays: [DdayInfo] = []
}

extension DDay {
    struct DdayInfo: Codable, Identifiable {
        var id: String//?
        var dday: String//?
//        var date: String//?
        var text: String//?
    }
}
