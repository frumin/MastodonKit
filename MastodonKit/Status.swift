//
//  Status.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public class Status: Codable {
    
    public let id: String
    public let uri: String
    public let url: String?
    public let user: User
    public let content: String
    public let reblog: Status?
    
    init?() {
        return nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case uri
        case url
        case user = "account"
        case content
        case reblog
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.uri = try container.decode(String.self, forKey: .uri)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.user = try container.decode(User.self, forKey: .user)
        self.content = try container.decode(String.self, forKey: .content)
        self.reblog = try container.decodeIfPresent(Status.self, forKey: .reblog)
    }
    
}
