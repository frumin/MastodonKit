//
//  AccountTests.swift
//  MastodonKitTests
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import XCTest

struct Params {
    
    let instance: String
    let user: String
    let pass: String
    
    init() {
        let environment = ProcessInfo.processInfo.environment
        instance = environment["TESTINSTANCE"]!
        user = environment["TESTUSER"]!
        pass = environment["TESTPASS"]!
    }
    
}

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfulAuthentication() {
        let params = Params()
        let authenticationExpectation = XCTestExpectation(description: "auth")
        
        let client = Client(url: URL(string: params.instance)!)
        
        let instanceTask = Instance.getInstanceTask
        let instanceParser = JSONParser<Instance>()
        
        client.perform(task: instanceTask) { (data, error) in
            let instance = try? instanceParser.parseBlock(data!)
            
            instance?.register(application: "MastodonKit", scopes: [.read]) { (registration, error) in
                guard let registration = registration else {
                    XCTAssert(false)
                    authenticationExpectation.fulfill()
                    return
                }
                Account.authenticate(user: params.user, password: params.pass, instance: instance!, app: registration, completion: { (account, authError) in
                    XCTAssertNil(authError)
                    XCTAssertNotNil(account)
                    authenticationExpectation.fulfill()
                })
            }
        }
        
        wait(for: [authenticationExpectation], timeout: 20)
    }
    
    func testFailedAuthentication() {
        let params = Params()
        let authenticationExpectation = XCTestExpectation(description: "auth")
        
        let client = Client(url: URL(string: params.instance)!)
        
        let instanceTask = Instance.getInstanceTask
        let instanceParser = JSONParser<Instance>()
        
        client.perform(task: instanceTask) { (data, error) in
            let instance = try? instanceParser.parseBlock(data!)
            
            instance?.register(application: "MastodonKit", scopes: [.read]) { (registration, error) in
                guard let registration = registration else {
                    XCTAssert(false)
                    authenticationExpectation.fulfill()
                    return
                }
                Account.authenticate(user: "a", password: "b", instance: instance!, app: registration, completion: { (account, authError) in
                    XCTAssertNotNil(authError)
                    XCTAssertNil(account)
                    authenticationExpectation.fulfill()
                })
            }
            
        }
        
        wait(for: [authenticationExpectation], timeout: 20)
    }
    
}
