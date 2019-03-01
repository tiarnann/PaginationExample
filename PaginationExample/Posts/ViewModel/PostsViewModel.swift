//
//  PostsViewModel.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsViewModelProtocol {
    var posts: [PostProtocol] { get }
    func nextPage(callback: @escaping (Error?)->())
}

struct PostsPageResult {
    let posts: [PostProtocol]
    let offest: Int?
    let limit: Int?
}

class PostsViewModel: PostsViewModelProtocol {
    private let repostiory: PostsRepositoryProtocol
    private(set) var posts: [PostProtocol]
    private var page: PostsPageResult?
    private var fetching = false
    
    init(repostiory: PostsRepositoryProtocol) {
        self.repostiory = repostiory
        self.posts = []
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
    
    func nextPage(callback: @escaping (Error?)->()) {
        guard !fetching else {
            return
        }
   
        self.fetching = true
        self.getPosts(page: self.page) { [weak self] result in
            guard let `self` = self else { return }
            result.map({ (page) -> Void in
                self.page = page
                self.posts.append(contentsOf: page.posts)
                callback(nil)
            }).catchError({ (error) in
                callback(error)
            })
            
            self.fetching = false
        }
    }
}
