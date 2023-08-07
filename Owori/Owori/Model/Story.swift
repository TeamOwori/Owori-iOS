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
        var story_images: [String]?
        var thumbnail: String?
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
            self.story_images = []
            self.thumbnail = ""
            self.title = ""
            self.writer = ""
            self.content = ""
            self.comments = []
            self.heart_count = 0
            self.comment_count = 0
            self.start_date = ""
            self.end_date = ""
        }
        
        init(id: Int, story_id: String, is_liked: Bool, story_images: [String], thumbnail: String, title: String, writer: String, content: String, comments: [Comment], heart_count: Int, comment_count: Int, start_date: String, end_date: String) {
            self.id = 0
            self.story_id = ""
            self.is_liked = false
            self.story_images = story_images
            self.thumbnail = thumbnail
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
        var parent_comment_id: String?
        var comment_id: String?
        var comment: String?
        var writer: String?
        var time_before_writing: String?
    }
}
