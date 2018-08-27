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
