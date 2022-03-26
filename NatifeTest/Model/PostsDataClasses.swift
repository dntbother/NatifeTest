//
//  PostsModel.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import Foundation

class Posts: Decodable {
    var posts: [PreviewPost]
    
    enum CodingKeys: String, CodingKey {
        case posts
    }
}

class PreviewPost: Decodable {
    var postId: Int
    var timeshamp: Double
    var title: String
    var previewText: String
    var likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}

class FullPostWrapper: Decodable {
    var fullPost: FullPost
    
    enum CodingKeys: String, CodingKey {
        case fullPost = "post"
    }
}

class FullPost: Decodable {
    var postId: Int
    var timeshamp: Double
    var title: String
    var text: String
    var images: [String]
    var likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case text
        case images
        case likesCount = "likes_count"
    }
}
