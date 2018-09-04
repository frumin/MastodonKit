//
//  Attachment.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 9/3/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

public class Attachment: Codable {
    
    public enum MediaType: String, Codable {
        case image
        case video
        case gifv
        case unknown
    }
    
    public struct Meta: Codable {
        
    }
    
    public let id: String
    public let type: MediaType
    public let url: String
    public let remoteURL: String?
    public let previewURL: String
    public let textURL: String?
//    let meta: Meta?
    public let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case remoteURL = "remote_url"
        case previewURL = "preview_url"
        case textURL = "text_url"
        case description
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(MediaType.self, forKey: .type)
        self.url = try container.decode(String.self, forKey: .url)
        self.remoteURL = try container.decodeIfPresent(String.self, forKey: .remoteURL)
        self.previewURL = try container.decode(String.self, forKey: .previewURL)
        self.textURL = try container.decodeIfPresent(String.self, forKey: .textURL)
//        self.meta = try container.decode(Meta.self, forKey: .meta)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
    
}
