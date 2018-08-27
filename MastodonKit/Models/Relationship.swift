//
//  Relationship.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public class Relationship: Codable {
    
    let id: String
    let isFollowing: Bool
    let isFollowedBy: Bool
    let isBlocking: Bool
    let isMuting: Bool
    let isMutingNotifications: Bool
    let didRequestFollow: Bool
    let isBlockingDomain: Bool
    let isShowingReblogs: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id
        case isFollowing = "following"
        case isFollowedBy = "followed_by"
        case isBlocking = "blocking"
        case isMuting = "muting"
        case isMutingNotifications = "muting_notifications"
        case didRequestFollow = "requested"
        case isBlockingDomain = "domain_blocking"
        case isShowingReblogs = "showing_reblogs"
    }
}
