//
//  PostDetailCoordinator.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 02/03/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation
import UIKit

protocol PostDetailCoordinatorProtocol: RootCoordinator { }

struct PostDetailCoordinator: PostDetailCoordinatorProtocol {
    let post: PostProtocol
    
    func instantiateRoot() -> UIViewController? {
        let viewController = PostDetailViewController(
            viewModel: PostDetailViewModel(post: self.post)
        )
        
        return viewController
    }
}
