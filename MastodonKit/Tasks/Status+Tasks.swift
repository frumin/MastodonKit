//
//  Status+Tasks.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

// MARK: - Get single status
public extension Status {
    
    public struct GetStatusTask: RequestTask {
        
        private let id: String
        
        public init(id: String) {
            self.id = id
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/statuses/\(id)")
            let request = URLRequest.mastodonRequest(url: url)
            return request
        }
        
    }
    
}

// MARK: - Post a single status.
public extension Status {
    
    public struct PostStatusTask: RequestTask {
        
        struct PostStatusPayload: Codable {
            let status: String
            let replyToId: String?
            let isSensitive: Bool
            let spoilerText: String?
            
            private enum CodingKeys: String, CodingKey {
                case status
                case replyToId = "in_reply_to_id"
                case isSensitive = "sensitive"
                case spoilerText = "spoiler_text"
            }
        }
        
        private let payload: [String: Any]
        
        public init(status: String, replyToId: String? = nil, sensitive: Bool = false, spoilerText: String? = nil) {
            var payload = ["status": status, "sensitive": sensitive] as [String : Any]
            if let replyToId = replyToId {
                payload["in_reply_to_id"] = replyToId
            }
            if let spoilerText = spoilerText {
                payload["spoiler_text"] = spoilerText
            }
            self.payload = payload
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/statuses")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            do {
                request.httpBody = try payload.formURLEncodedData()
            } catch {
                assert(false, error.localizedDescription)
            }
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            return request
        }
        
    }
    
}
