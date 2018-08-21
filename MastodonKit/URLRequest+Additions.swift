//
//  URLRequest+Additions.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

extension URLRequest {
    
    func signed(with token: String) -> URLRequest {
        var request = self
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}
