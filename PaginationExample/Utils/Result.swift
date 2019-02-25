//
//  Result.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 25/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation

/// Wraps a sequence of operations.
//  Propogates errors and values that occur in the sequence
enum Result<Wrapped> {
    case success(Wrapped)
    case error(Error)
    
    func map<T>(_ transform: (Wrapped) -> T) -> Result<T> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .error(let error):
            return Result<T>.error(error)
        }
    }
    
    func map<T>(_ transform: (Wrapped) throws -> T ) -> Result<T> {
        switch self {
        case .success(let value):
            do {
                return .success(try transform(value))
            } catch let err {
                return Result<T>.error(err)
            }
        case .error(let error):
            return Result<T>.error(error)
        }
    }
    
    func flatMap<T>(_ transform: (Wrapped) -> Result<T>) -> Result<T> {
        return self.map(transform).flatten()
    }
    
    func flatten<T>() -> Result<T> where Wrapped == Result<T> {
        switch self {
        case .success(let value):
            return value
        case .error(let error):
            return .error(error)
        }
    }
    
    func catchError(_ handler: (Error) -> ()) {
        switch self {
        case .success(_): break
        case .error(let error):
            return handler(error)
        }
    }
}

private func identity<T>(_ x: T) -> T { return x }
