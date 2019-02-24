//
//  PostsRepository.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostsRepositoryProtocol {
    func getPosts() -> [Post]
}

struct PostsRepository: PostsRepositoryProtocol {
    func getPosts() -> [Post] {
        return [
            Post(
                userId: 2,
                id: 19,
                title: "1. adipisci placeat illum aut reiciendis qui",
                body: "illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas"
            ),
            Post(
                userId: 2,
                id: 19,
                title: "2. adipisci placeat illum aut reiciendis qui",
                body: "illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas"
            ),
            Post(
                userId: 2,
                id: 19,
                title: "3. adipisci placeat illum aut reiciendis qui",
                body: "illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas"
            ),
            Post(
                userId: 2,
                id: 19,
                title: "4. adipisci placeat illum aut reiciendis qui",
                body: "illum quis cupiditate provident sit magnam\nea sed aut omnis\nveniam maiores ullam consequatur atque\nadipisci quo iste expedita sit quos voluptas"
            )
        ]
    }
}
