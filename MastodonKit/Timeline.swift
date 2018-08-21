//
//  Timeline.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public struct Timeline {
    
    public let statuses: [Status]
    
    init?(data: Data) {
        let decoder = JSONDecoder()
        guard let statuses = try? decoder.decode([Status].self, from: data) else {
            return nil
        }
        self.statuses = statuses
    }
    
}

public extension Timeline {
    
    public typealias HomeCompletion = (_ timeline: Timeline?, _ error: Error?) -> Void
    
    @discardableResult
    public static func getHome(for account: Account, instance: Instance, completion: HomeCompletion?) -> URLSessionTask {
        let request = URLRequest.timelineRequest(for: account, instance: instance)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data, let timeline = Timeline(data: data) else {
                completion?(nil, error)
                return
            }
            completion?(timeline, nil)
        }
        task.resume()
        return task
    }
    
}

private extension URLRequest {
    
    static func timelineRequest(for account: Account, instance: Instance) -> URLRequest {
        let url = instance.url.appendingPathComponent("/api/v1/timelines/home")
        let request = URLRequest(url: url).signed(with: account.token)
        
        return request
    }
    
}
