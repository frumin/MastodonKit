//
//  Account.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public struct Account: Codable {
    
    public let token: String
    
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
    
}

public extension Account {
    
    public typealias AuthenticationCompletion = (_ account: Account?, _ error: Error?) -> Void
    
    @discardableResult
    public static func authenticate(user: String, password: String, instance: Instance, app: App, completion: AuthenticationCompletion?) -> URLSessionTask {
        let request = URLRequest.authenticationRequest(for: user, password: password, instance: instance, registration: app)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion?(nil, error)
                return
            }
            do {
                let account = try Account.init(data: data)
                completion?(account, nil)
            } catch {
                completion?(nil, error)
            }
        }
        task.resume()
        return task
    }
    
}

private extension URLRequest {
    
    static func authenticationRequest(for user: String, password: String, instance: Instance, registration: App) -> URLRequest {
        let url = instance.url.appendingPathComponent("/oauth/token")
        var request = URLRequest(url: url)
        let payload = ["client_id": registration.clientId,
                       "client_secret": registration.clientSecret,
                       "username": user,
                       "password": password,
                       "grant_type": "password"]
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload.formURLEncoded
        
        return request
    }
    
}

private extension Dictionary where Key == String, Value == String {
    
    var formURLEncoded: Data {
        var combined = ""
        keys.forEach { (key) in
            if combined.count > 0 {
                combined += "&"
            }
            combined += "\(key)=\(self[key]!)"
        }
        guard let data = combined.data(using: .utf8) else {
            fatalError("Couldn't URL encode dictionary")
        }
        return data
    }
    
}
