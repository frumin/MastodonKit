//
//  Instance.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public class Instance: Codable {
    
    public let uri: String
    public let title: String
    public let description: String
    public let contactEmail: String
    public let contact: User
    public let version: String
    public let urls: [String: String]
    public let languages: [String] // ISO 6391
    
    private enum CodingKeys: String, CodingKey {
        case uri
        case title
        case description
        case contactEmail = "email"
        case contact = "contact_account"
        case version
        case urls
        case languages
    }
    
}

public extension Instance {
    
    public var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = uri
        return components.url!
    }
    
}

public extension Instance {
    
    public typealias InstanceCompletion = (_ instance: Instance?, _ error: Error?) -> Void
    
    @discardableResult
    public static func instace(at url: URL, completion: InstanceCompletion?) -> URLSessionTask {
        let request = URLRequest.instanceRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion?(nil, error)
                return
            }
            do {
                let instance = try Instance(data: data)
                completion?(instance, nil)
            } catch {
                completion?(nil, error)
            }
        }
        task.resume()
        return task
    }
    
}

private extension URLRequest {
    
    static func instanceRequest(url instanceURL: URL) -> URLRequest {
        let url = instanceURL.appendingPathComponent("/api/v1/instance")
        return URLRequest(url: url)
    }
    
}
