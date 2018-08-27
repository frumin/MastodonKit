//
//  User+Tasks.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

// MARK: - Get user
public extension User {
    
    public struct GetUserTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)")
            let request = URLRequest.mastodonRequest(url: url)
            return request
        }
        
    }
    
}

public extension User {
    
    public struct GetUserFollowersTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/followers")
            let request = URLRequest.mastodonRequest(url: url)
            return request
        }
        
    }
    
}

public extension User {
    
    public struct GetUserFollowingTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/following")
            let request = URLRequest.mastodonRequest(url: url)
            return request
        }
        
    }
    
}

public extension User {
    
    public struct GetUserStatusesTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/statuses")
            let request = URLRequest.mastodonRequest(url: url)
            return request
        }
        
    }
    
}

public extension User {
    
    public struct GetUserRelationshipsTask: RequestTask {
        
        private let ids: [String]
        
        public init(ids: [String]) {
            self.ids = ids
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/relationships")
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                assert(false, "Couldn't create query")
                return URLRequest.mastodonRequest(url: url)
            }
            let idsQuery = URLQueryItem(name: "id", value: ids.reduce("") { $0 + ($0.count > 0 ? "," : $0) + $1 })
            components.queryItems = [idsQuery]
            let request = URLRequest.mastodonRequest(url: components.url!)
            return request
        }
        
    }
    
}

public extension User {
    
    public struct FollowUserRelationshipTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/follow")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
        
    }
    
}

public extension User {
    
    public struct UnfollowUserRelationshipTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/unfollow")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
        
    }
    
}

public extension User {
    
    public struct BlockUserRelationshipTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/block")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
        
    }
    
}

public extension User {
    
    public struct UnblockUserRelationshipTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/unblock")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
        
    }
    
}

public extension User {
    
    public struct MuteUserRelationshipTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/mute")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
        
    }
    
}

public extension User {
    
    public struct UnmuteUserRelationshipTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/accounts/\(id)/unmute")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
        
    }
    
}
