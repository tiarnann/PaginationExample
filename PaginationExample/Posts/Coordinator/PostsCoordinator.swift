//
//  PostsCoordinator.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

struct PostsCoordinator: RootCoordinator {
    func instantiateRoot() -> UIViewController? {
        let viewModel = PostsViewModel(
            repostiory: PostsRepository()
        )
        
        let viewController = PostsViewController(viewModel: viewModel)
        
        return viewController
    }
}
