//
//  Instance+Tasks.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

// MARK: - Get instance task
public extension Instance {
    
    public struct GetInstanceTask: RequestTask {
        
        public init() { }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("api/v1/instance")
            return URLRequest.mastodonRequest(url:url)
        }
        
    }
    
}
