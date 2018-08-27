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
