//
//  PostsRepository.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsRepositoryProtocol {
    func getPosts(callback: @escaping (Result<[PostProtocol]>) -> ())
    func getPosts(offset: Int, limit: Int, callback: @escaping (Result<[PostProtocol]>) -> ())
}

struct PostsRepository: PostsRepositoryProtocol {
    let api: PostsAPIProtocol
    
    init(api: PostsAPIProtocol) {
        self.api = api
    }
    
    func getPosts(callback: @escaping (Result<[PostProtocol]>) -> ()) {
        self.api.getPosts(
            callback: callback
        )
    }
    
    func getPosts(offset: Int, limit: Int, callback: @escaping (Result<[PostProtocol]>) -> ()) {
        self.api.getPosts(offset: offset, limit: limit, callback: callback)
    }
}
