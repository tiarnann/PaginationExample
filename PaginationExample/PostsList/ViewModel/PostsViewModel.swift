//
//  PostsViewModel.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

protocol PostsViewModelProtocol {
    var posts: [PostProtocol] { get }
    func nextPage(callback: @escaping (Error?)->())
    func didSelectPost(viewController: UIViewController, post: PostProtocol)
}

struct PostsPageResult {
    let posts: [PostProtocol]
    let offest: Int?
    let limit: Int?
}

class PostsViewModel: PostsViewModelProtocol {
    private let coordinator: PostsCoordinatorProtocol
    private let repostiory: PostsRepositoryProtocol
    private(set) var posts: [PostProtocol]
    private var page: PostsPageResult?
    private var fetching = false
    
    init(coordinator: PostsCoordinatorProtocol, repostiory: PostsRepositoryProtocol) {
        self.coordinator = coordinator
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
    
    func didSelectPost(viewController: UIViewController, post: PostProtocol) {
        self.coordinator.navigateTo(post: post, presentingViewController: viewController)
    }
}
