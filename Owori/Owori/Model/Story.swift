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
    struct StoryInfo: Hashable, Codable, Identifiable {
        var id: Int?
        var story_id: String?
        var is_liked: Bool?
        var images: [String]?
        var image: String?
        var title: String?
        var writer: String?
        var content: String?
        var heart_count: Int?
        var comment_count: Int?
        var comments: [Comment]?
        var start_date: String?
        var end_date: String?

        // 기본 init
        init() {
            self.id = 0
            self.story_id = ""
            self.is_liked = false
            self.images = []
            self.image = ""
            self.title = ""
            self.writer = ""
            self.content = ""
            self.comments = []
            self.heart_count = 0
            self.comment_count = 0
            self.start_date = ""
            self.end_date = ""
        }
        
        init(id: Int, story_id: String, is_liked: Bool, images: [String], image: String, title: String, writer: String, content: String, comments: [Comment], heart_count: Int, comment_count: Int, start_date: String, end_date: String) {
            self.id = 0
            self.story_id = ""
            self.is_liked = false
            self.images = images
            self.image = image
            self.title = title
            self.writer = writer
            self.content = content
            self.comments = []
            self.heart_count = 0
            self.comment_count = 0
            self.start_date = start_date
            self.end_date = end_date
        }
    }
}

extension Story.StoryInfo {
    struct Comment: Hashable, Codable, Identifiable {
        var id: Int?
        var parent_comment_id: Int?
        var comment_id: Int?
        var comment: String?
        var writer: String?
        var time_before_writing: String?
    }
}
