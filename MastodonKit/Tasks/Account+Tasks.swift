//
//  Account+Tasks.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public extension Account {
    
    public struct AuthenticateAccountTask: RequestTask {
        
        private let user: String
        private let pass: String
        private let instance: Instance
        private let app: App
        
        public init(user: String, password: String, instance: Instance, app: App) {
            self.user = user
            self.pass = password
            self.instance = instance
            self.app = app
        }
        
        public func request(with baseURL: URL) -> URLRequest {
            let url = baseURL.appendingPathComponent("/oauth/token")
            var request = URLRequest.mastodonRequest(url: url)
            let payload = ["client_id": app.clientId,
                           "client_secret": app.clientSecret,
                           "username": user,
                           "password": pass,
                         "grant_type": "password"] as [String: Any]
            
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
