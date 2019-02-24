//
//  Post.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 24/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

protocol PostProtocol {
    var userId: Int { get }
    var id: Int { get }
    var title: String { get }
    var body: String { get }
}

struct Post: Codable, PostProtocol {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
