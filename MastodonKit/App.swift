//
//  App.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public struct App: Codable {
    
    let id: String
    let clientId: String
    let clientSecret: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
    
}

public extension Instance {
    
    public typealias RegistrationCompletion = (_ registration: App?, _ error: Error?) -> Void
    
    public enum AccessScope: String {
        case read
        case write
        case follow
    }
    
    @discardableResult
    public func register(application name: String, redirectURIs: [String] = ["urn:ietf:wg:oauth:2.0:oob"], scopes: [AccessScope], appURL: URL? = nil, completion: RegistrationCompletion?) -> URLSessionTask {
        let request = URLRequest.request(for: .apps,
                                         baseURL: url,
                                         name: name,
                                         redirectURIs: redirectURIs,
                                         scopes: scopes.map { $0.rawValue },
                                         appURL: appURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                if error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let error = NSError(domain: "com.acidbits.mastodonkit.App", code: statusCode, userInfo: nil)
                    completion?(nil, error)
                } else {
                    completion?(nil, error)
                }
                return
            }
            do {
                let registration = try App(data: data)
                completion?(registration, nil)
            } catch {
                completion?(nil, error)
            }
        }
        task.resume()
        return task
    }
    
}

private extension URLRequest {
    
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
    
    enum Endpoint {
        case apps
    }
    
    static func request(for endpoint: Endpoint, baseURL: URL, name: String, redirectURIs: [String], scopes: [String], appURL: URL?) -> URLRequest {
        switch endpoint {
        case .apps:
            let encoder = JSONEncoder()
            let url = baseURL.appendingPathComponent("/api/v1/apps")
            var request = URLRequest(url: url)
            let payload = AppRequestPayload(applicationName: name, redirectURIs: redirectURIs.reduce("") { $0 + ($0.count > 0 ? "," : $0) + $1 }, scopes: scopes, appURL: appURL?.absoluteString)
            
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try encoder.encode(payload)
            } catch {
                assertionFailure(error.localizedDescription)
            }
            
            return request
        }
    }
    
}
