//
//  Networking.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/22/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

enum MastodonKitError: Swift.Error {
    case string(String)
}

public protocol RequestTask {
    
    func request(with baseURL: URL) -> URLRequest
    
}

public protocol Client {
    
    associatedtype TaskCompletion
    
    var baseURL: URL { get }
    
    func perform(task: RequestTask, completion: TaskCompletion?) -> URLSessionTask
    
}

public class UnauthenticatedClient {
    
    public typealias TaskCompletion = (_ data: Data?, _ error: Error?) -> Void
    
    public private(set) var baseURL: URL
    
    public init(url: URL) {
        self.baseURL = url
    }
    
    @discardableResult
    public func perform(task: RequestTask, completion: TaskCompletion?) -> URLSessionTask {
        let request = task.request(with: baseURL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response?.error == nil else {
                completion?(nil, response?.error)
                return
            }
            completion?(data, nil)
        }
        task.resume()
        return task
    }
    
}

public class AuthenticatedClient {
    
    public typealias TaskCompletion = (_ data: Data?, _ error: Error?) -> Void
    
    public private(set) var baseURL: URL
    
    private let instance: Instance
    private let app: App
    private let account: Account
    
    public init(instance: Instance, app: App, account: Account) {
        self.baseURL = instance.url
        self.instance = instance
        self.account = account
        self.app = app
    }
    
    @discardableResult
    public func perform(task: RequestTask, completion: TaskCompletion?) -> URLSessionTask {
        let request = task.request(with: baseURL).signed(with: account.token)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion?(nil, error)
                return
            }
            guard response?.error == nil else {
                completion?(nil, response?.error)
                return
            }
            completion?(data, nil)
        }
        task.resume()
        return task
    }
    
}

extension URLResponse {
    
    var error: Error? {
        guard let response = self as? HTTPURLResponse else {
            return nil
        }
        if response.statusCode >= 300 || response.statusCode < 200 {
            return MastodonKitError.string("Received status code \(response.statusCode)")
        }
        return nil
    }
    
}
