//
//  PostsCoordinator.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

protocol PostsCoordinatorProtocol: RootCoordinator {
    func navigateTo(post: PostProtocol, presentingViewController: UIViewController)
}

struct PostsCoordinator: PostsCoordinatorProtocol {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func instantiateRoot() -> UIViewController? {
        let viewModel = PostsViewModel(
            coordinator: self,
            repostiory: PostsRepository(
                api: PostsAPI(networkManager: networkManager)
            )
        )
        
        return PostsViewController(viewModel: viewModel)
    }
    
    func navigateTo(post: PostProtocol, presentingViewController: UIViewController) {
        if let postDetailVC = PostDetailCoordinator(post: post).instantiateRoot() {
            presentingViewController.navigationController?.pushViewController(postDetailVC, animated: true)
        } else {
            // show error
        }
    }
}
