//
//  Requestable.swift
//  MastodonKit
//
//  Created by Tom Zaworowski on 8/20/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import Foundation

protocol Requestable {
    
    associatedtype RequestType
    
    static func request(for type: RequestType) -> URLRequest
    
}
