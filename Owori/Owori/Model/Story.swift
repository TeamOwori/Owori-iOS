//
//  Story.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import Foundation

struct Story: Codable {
    var stories: [StoryInfo] = []
}

extension Story {
    struct StoryInfo: Codable, Identifiable {
        var id: UUID?
        var is_liked: Bool?
        var images: [String]?
        var title: String?
        var writer: String?
        var contents: String?
        var comments: [Comment]?
        var heart_cnt: Int?
        var comment_cnt: Int?
        var start_date: String?
        var end_date: String?

        // 기본 init
        init() {
            self.is_liked = false
            self.images = []
            self.title = ""
            self.writer = ""
            self.contents = ""
            self.comments = []
            self.heart_cnt = 0
            self.comment_cnt = 0
            self.start_date = ""
            self.end_date = ""
        }
        
        init(id: UUID, is_liked: Bool, images: [String], title: String, writer: String, contents: String, comments: [Comment], heart_cnt: Int, comment_cnt: Int, start_date: String, end_date: String) {
            self.id = id
            self.is_liked = false
            self.images = images
            self.title = title
            self.writer = writer
            self.contents = contents
            self.comments = []
            self.heart_cnt = 0
            self.comment_cnt = 0
            self.start_date = start_date
            self.end_date = end_date
        }
    }
}

extension Story.StoryInfo {
    struct Comment: Codable {
        var parent_comment_id: Int?
        var comment_id: Int?
        var comment: String?
        var writer: String?
        var time_before_writing: String?
    }
}
