//
//  PostsViewModel.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsViewModelProtocol {
    func getPosts(callback: @escaping ([PostProtocol]?) -> ())
}

struct PostsViewModel: PostsViewModelProtocol {
    private let repostiory: PostsRepositoryProtocol
    private var posts: [PostProtocol]?
    
    init(repostiory: PostsRepositoryProtocol) {
        self.repostiory = repostiory
    }
    
    func getPosts(callback: @escaping ([PostProtocol]?) -> ()) {
        self.repostiory.getPosts(callback: { posts, _ in
            callback(posts)
        })
    }
}
