//
//  PostsViewModel.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsViewModelProtocol {
    func getPosts() -> [Post]
}

struct PostsViewModel: PostsViewModelProtocol {
    private let repostiory: PostsRepositoryProtocol
    
    init(repostiory: PostsRepositoryProtocol) {
        self.repostiory = repostiory
    }
    
    func getPosts() -> [Post] {
        return self.repostiory.getPosts()
    }
}
