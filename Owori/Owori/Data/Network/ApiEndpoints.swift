//
//  ApiEndpoints.swift
//  Owori
//
//  Created by kyungsoolee on 4/2/24.
//

import Foundation

enum ApiEndpoints {
    // dev
    static let scheme = "http"
    static let host = "13.124.20.243"
    static let version = "/api/v1"
//    static let port = 8080
    
    enum Path: String {
        // members
        case members = "/members"
        case membersKakao = "/members/kakao"
        case membersApple = "/members/apple"
        case membersGoogle = "/members/google"
        case refresh = "/auth/refresh"
        case membersDetails = "/members/details"
        case membersEmtionalBadge = "/members/emotional-badge"
        case membersProfile = "/members/profile"
        case membersColors = "/members/colors"
        case membersProfileImage = "/members/profile-image"
        case membersHome = "/members/home"
        
        // stories
        case stories = "/stories"
        case storiesUpdate = "/stories/update"
        case storiesSortLastViewed = "/stories?sort=created_at&last_viewed="
        case storiesFindSortStartDate = "/stories/find"
        
        //families
        case families = "/families"
        case familiesMember = "/families/members"
        case familiesGroupName = "/families/group-name"
        case familiesCode = "/families/code"
        case familiesImages = "/families/images"
        
        // schedule
        case schedule = "/schedule"
        case scheduleUpdate = "/schedule/update"
        
        // images
        case images = "/images"
        
        // hearts
        case hearts = "/hearts"
        
    }
}


extension ApiEndpoints {
    static func getBasicUrlComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = ApiEndpoints.scheme
        urlComponents.host = ApiEndpoints.host
        urlComponents.path = ApiEndpoints.version
//        urlComponents.port = ApiEndpoints.port
        return urlComponents
    }
}
