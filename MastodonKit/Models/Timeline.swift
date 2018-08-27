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
    
    public init(jsonData: Data) throws {
        let decoder = JSONDecoder()
        self.statuses = try decoder.decode([Status].self, from: jsonData)
    }
    
}
