//
//  PostsViewModel.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsViewModelProtocol {
    func getPosts(page: PostsPageResult?, callback: @escaping (Result<PostsPageResult>) -> ())
}

struct PostsPageResult {
    let posts: [PostProtocol]
    let offest: Int?
    let limit: Int?
}

struct PostsViewModel: PostsViewModelProtocol {
    private let repostiory: PostsRepositoryProtocol
    
    init(repostiory: PostsRepositoryProtocol) {
        self.repostiory = repostiory
    }
    
    func getPosts(page: PostsPageResult?, callback: @escaping (Result<PostsPageResult>) -> ()) {
        let handler = { (result: Result<[PostProtocol]>) in
            let page = result.map({ (posts: [PostProtocol]) -> PostsPageResult in
                return PostsPageResult(
                    posts: posts,
                    offest: posts.last?.id,
                    limit: posts.count
                )
            })
            
            callback(page)
        }
        
        if let offset = page?.offest, let limit = page?.limit {
            self.repostiory.getPosts(offset: offset, limit: limit, callback: handler)
        } else {
            self.repostiory.getPosts(callback: handler)
        }
        
    }
}
