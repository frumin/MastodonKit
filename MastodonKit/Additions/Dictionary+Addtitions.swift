//
//  Dictionary+Addtitions.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/26/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    func formURLEncodedData() throws -> Data {
        var combined = ""
        keys.forEach { (key) in
            if combined.count > 0 {
                combined += "&"
            }
            combined += "\(key)=\(self[key]!)"
        }
        guard let data = combined.data(using: .utf8) else {
            throw MastodonKitError.string("Couldn't encode dictionary.")
        }
        return data
    }
    
}
