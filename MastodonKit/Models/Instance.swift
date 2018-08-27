//
//  Instance.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public struct Emoji: Codable {
    public let shortcode: String
    public let url: String
    public let staticURL: String
    public let isVisibleInPicker: Bool
    
    private enum CodingKeys: String, CodingKey {
        case shortcode
        case url
        case staticURL = "static_url"
        case isVisibleInPicker = "visible_in_picker"
    }
}

public class Instance: Codable {
    
    public let uri: String
    public let title: String
    public let description: String
    public let contactEmail: String
    public let contact: User
    public let version: String
    public let urls: [String: String]
    public let languages: [String] // ISO 6391
    
    private enum CodingKeys: String, CodingKey {
        case uri
        case title
        case description
        case contactEmail = "email"
        case contact = "contact_account"
        case version
        case urls
        case languages
    }
    
}

public extension Instance {
    
    public var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = uri
        return components.url!
    }
    
}
