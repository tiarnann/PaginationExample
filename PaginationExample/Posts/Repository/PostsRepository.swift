//
//  PostsRepository.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsRepositoryProtocol {
    func getPosts(callback: @escaping ([PostProtocol]?, Error?) -> ())
}

struct PostsRepository: PostsRepositoryProtocol {
    let api: PostsAPIProtocol
    
    init(api: PostsAPIProtocol) {
        self.api = api
    }
    
    func getPosts(callback: @escaping ([PostProtocol]?, Error?) -> ()) {
        self.api.getPosts(
            callback: callback
        )
    }
}
