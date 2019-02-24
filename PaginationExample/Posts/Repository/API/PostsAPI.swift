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
    func getPosts(callback: @escaping ([PostProtocol]?, Error?)->())
    func getPosts(offset: Int, limit: Int, callback: @escaping ([PostProtocol]?, Error?)->())
}

struct PostsAPI: PostsAPIProtocol {
    private let urlSession: URLSession
    
    init() {
        self.urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func getPosts(callback: @escaping ([PostProtocol]?, Error?)->()) {
        let url = URL(string: "http://jsonplaceholder.typicode.com/posts")!
        self.getPosts(url: url, callback: callback)
    }
    
    func getPosts(offset: Int, limit: Int, callback: @escaping ([PostProtocol]?, Error?)->()) {
         let url = URL(string: "http://jsonplaceholder.typicode.com/posts?_start=\(offset)&_limit=\(limit)")!
        self.getPosts(url: url, callback: callback)
    }
    
    func getPosts(url: URL, callback: @escaping ([PostProtocol]?, Error?)->()) {
        let request = URLRequest(
            url: url,
            cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData,
            timeoutInterval: 10.0
        )
        self.urlSession.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                if let error = error {
                    callback(nil, PostsAPIError.network(error))
                    return
                }
                
                if let data = data {
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)
                        callback(posts, nil)
                        return
                    } catch let err {
                        callback(nil, PostsAPIError.parsing(err))
                        return
                    }
                }
                
                callback([], nil)
        }).resume()
    }
}
