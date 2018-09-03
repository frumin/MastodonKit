//
//  Account.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public struct Authorization: Codable {
    
    public private(set) var name: String?
    public let token: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case token = "access_token"
    }
    
    public init(jsonData: Data, name: String) throws {
        try self.init(jsonData: jsonData)
        self.name = name
    }
    
}
