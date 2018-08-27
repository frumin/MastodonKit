//
//  App+Tasks.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public extension Instance {
    
    public struct RegisterAppTask: RequestTask {
        
        public enum AccessScope: String {
            case read
            case write
            case follow
        }
        
        private struct AppRequestPayload: Codable {
            
            let applicationName: String
            let redirectURIs: String
            let scopes: [String]
            let appURL: String?
            
            private enum CodingKeys: String, CodingKey {
                case applicationName = "client_name"
                case redirectURIs = "redirect_uris"
                case scopes
                case appURL = "website"
            }
            
        }
        
        private let payload: AppRequestPayload
        
        public init(name: String, redirectURIs: [String] = ["urn:ietf:wg:oauth:2.0:oob"], scopes: [AccessScope], appURL: URL? = nil) {
            self.payload = AppRequestPayload(applicationName: name,
                                             redirectURIs: redirectURIs.reduce("") { $0 + ($0.count > 0 ? "," : $0) + $1 },
                                             scopes: scopes.map { $0.rawValue },
                                             appURL: appURL?.absoluteString)
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/api/v1/apps")
            var request = URLRequest.mastodonRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            
            do {
                request.httpBody = try encoder.encode(payload)
            } catch {
                assertionFailure(error.localizedDescription)
            }
            
            return request
        }
        
    }
    
}
