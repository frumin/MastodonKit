//
//  Timeline+Tasks.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public extension Timeline {
    
    public struct GetHomeTimelineTask: RequestTask {
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/timelines/home")
            let request = URLRequest(url: url)
            
            return request
        }
        
        public init() {}
    }
    
}
