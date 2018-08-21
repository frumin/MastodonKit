//
//  Decodable+Additions.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/19/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

extension Decodable {
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
    
}
