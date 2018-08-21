//
//  User.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public class User: Codable {
    
    public let id: String
    public let username: String
    public let name: String
    public let displayName: String
    public let isLocked: Bool
    public let createdAt: String
    public let numberOfFollowers: Int
    public let numberOfFollowing: Int
    public let postCount: Int
    public let bio: String
    public let url: String
    public let avatarURL: String
    public let staticAvatarURL: String
    public let headerURL: String
    public let staticHeaderURL: String
    public let emojis: [String]
    public let movedTo: User?
    public let isBot: Bool?
    // missing fields
    
    init?() {
        return nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case name = "acct"
        case displayName = "display_name"
        case isLocked = "locked"
        case createdAt = "created_at"
        case numberOfFollowers = "followers_count"
        case numberOfFollowing = "following_count"
        case postCount = "statuses_count"
        case bio = "note"
        case url
        case avatarURL = "avatar"
        case staticAvatarURL = "avatar_static"
        case headerURL = "header"
        case staticHeaderURL = "header_static"
        case emojis
        case movedTo = "moved"
        case isBot = "bot"
    }
}
