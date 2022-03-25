//
//  APIService.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 25.03.2022.
//

import Foundation
import Alamofire

class PostsService {
    private let baseUrl = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/"
    private let allPostsUrlAddition = "main.json"
    private let fullPostUrlAddition = "posts/"
    
    func fetchPosts(completion: @escaping (Posts?)->Void) {
        let url = baseUrl + allPostsUrlAddition
        let request = AF.request(url)
        
        request.responseDecodable(of: Posts.self) { response in
            if let posts = response.value {
                completion(posts)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchFullPost(with id: Int, completion: @escaping (FullPost?)->Void) {
        let url = baseUrl + fullPostUrlAddition + "\(id).json"
        let request = AF.request(url)
        
        request.responseDecodable(of: FullPostWrapper.self) { response in
            if let wrapper = response.value {
                completion(wrapper.fullPost)
            } else {
                completion(nil)
            }
        }
    }
}
