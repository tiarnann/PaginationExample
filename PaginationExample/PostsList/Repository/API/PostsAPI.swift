//
//  PostsAPI.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

enum PostsAPIError: Error {
    case parsing(Error)
    case network(Error)
}

protocol PostsAPIProtocol {
    func getPosts(callback: @escaping (Result<[PostProtocol]>)->())
    func getPosts(offset: Int, limit: Int, callback: @escaping (Result<[PostProtocol]>)->())
}

struct PostsAPI: PostsAPIProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getPosts(callback: @escaping (Result<[PostProtocol]>)->()) {
        let request = self.networkManager.buildRequest(url: "http://jsonplaceholder.typicode.com/posts?_limit=20")
        self.networkManager.performAndDecodeRequest(request: request) { (posts: Result<[Post]>) in
            callback(posts.map({ (posts) -> [PostProtocol] in
                return posts
            }))
        }
    }
    
    func getPosts(offset: Int, limit: Int, callback: @escaping (Result<[PostProtocol]>)->()) {
        let request = self.networkManager.buildRequest(url: "http://jsonplaceholder.typicode.com/posts?_start=\(offset)&_limit=\(limit)")
        self.networkManager.performAndDecodeRequest(request: request) { (posts: Result<[Post]>) in
            callback(posts.map({ (posts) -> [PostProtocol] in
                return posts
            }))
        }
    }

}
