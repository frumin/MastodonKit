//
//  Mention.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 9/3/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public struct Mention: Codable {
    
    let url: String
    let username: String
    let account: String
    let accountId: String
    
    private enum CodingKeys: String, CodingKey {
        case url
        case username
        case account = "acct"
        case accountId = "id"
    }
    
}
