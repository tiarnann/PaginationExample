//
//  NetworkManager.swift
//  PaginationExample
//
//  Created by Tíarnán McGrath on 25/02/2019.
//  Copyright © 2019 Tíarnán McGrath. All rights reserved.
//

import Foundation


protocol NetworkManagerProtocol {
    func buildRequest(url: String) -> URLRequest
    func decodeRequest<T: Decodable>(data: Data) -> Result<T>
    func performRequest(request: URLRequest, callback: @escaping (Result<(Data, HTTPURLResponse)>)->())
    func performAndDecodeRequest<T: Decodable>(request: URLRequest, callback: @escaping (Result<T>)->())
}

struct NetworkManager: NetworkManagerProtocol {
    init() {}

    func buildRequest(url: String) -> URLRequest {
        return URLRequest(
            url: URL(string: url)!,
            cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData,
            timeoutInterval: 10.0
        )
    }
    
    func performRequest(request: URLRequest, callback: @escaping (Result<(Data, HTTPURLResponse)>)->()) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse // this force unwrapping is safe
            
            if let error = error {
                callback(.error(error))
                return
            }
            
            callback(.success((data!, httpResponse)))
        }.resume()
    }
    
    func performAndDecodeRequest<T: Decodable>(request: URLRequest, callback: @escaping (Result<T>)->()) {
        self.performRequest(request: request) { (result) in
            let maybeParsed: Result<T> = result.flatMap({ (pair) -> Result<T> in
                return self.decodeRequest(data: pair.0)
            })
            
            callback(maybeParsed)
        }
    }
    
    func decodeRequest<T: Decodable>(data: Data) -> Result<T> {
        do {
            return try .success(JSONDecoder().decode(T.self, from: data))
        } catch {
            return .error(error)
        }
    }
}
