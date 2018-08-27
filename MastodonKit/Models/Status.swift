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
    public let repliedToId: String?
    public let repliedAccountId: String?
    public let reblog: Status?
    public let createdAt: String
    public let emojis: [Emoji]
    public let replyCount: Int
    public let reblogCount: Int
    public let favoriteCount: Int
    public let isReblogged: Bool?
    public let isFavorited: Bool?
    public let isMuted: Bool?
    public let isSensitive: Bool
    public let spoilerText: String?
    public let isPinned: Bool?
    
    init?() {
        return nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case uri
        case url
        case user = "account"
        case content
        case repliedToId = "in_reply_to_id"
        case repliedAccountId = "in_reply_to_account_id"
        case reblog
        case createdAt = "created_at"
        case emojis
        case replyCount = "replies_count"
        case reblogCount = "reblogs_count"
        case favoriteCount = "favourites_count"
        case isReblogged = "reblogged"
        case isFavorited = "favourited"
        case isMuted = "muted"
        case isSensitive = "sensitive"
        case spoilerText = "spoiler_text"
        case isPinned = "pinned"
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.uri = try container.decode(String.self, forKey: .uri)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.user = try container.decode(User.self, forKey: .user)
        self.content = try container.decode(String.self, forKey: .content)
        self.repliedToId = try container.decodeIfPresent(String.self, forKey: .repliedToId)
        self.repliedAccountId = try container.decodeIfPresent(String.self, forKey: .repliedAccountId)
        self.reblog = try container.decodeIfPresent(Status.self, forKey: .reblog)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.emojis = try container.decode([Emoji].self, forKey: .emojis)
        self.replyCount = try container.decode(Int.self, forKey: .replyCount)
        self.reblogCount = try container.decode(Int.self, forKey: .reblogCount)
        self.favoriteCount = try container.decode(Int.self, forKey: .favoriteCount)
        self.isReblogged = try container.decodeIfPresent(Bool.self, forKey: .isReblogged)
        self.isFavorited = try container.decodeIfPresent(Bool.self, forKey: .isFavorited)
        self.isMuted = try container.decodeIfPresent(Bool.self, forKey: .isMuted)
        self.isSensitive = try container.decode(Bool.self, forKey: .isSensitive)
        self.spoilerText = try container.decodeIfPresent(String.self, forKey: .spoilerText)
        self.isPinned = try container.decodeIfPresent(Bool.self, forKey: .isPinned)
    }
    
}
