//
//  AppRegistrationTests.swift
//  MastodonKitTests
//
//  Created by Tom Zaworowski on 8/18/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import XCTest

class AppRegistrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApplicationRegistrationSuccess() {
        let params = Params()
        let registrationExpecation = expectation(description: "registration")
        
        let client = Client(url: URL(string: params.instance)!)
        
        let instanceTask = Instance.getInstanceTask
        let instanceParser = JSONParser<Instance>()
        
        client.perform(task: instanceTask) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            let instance = try? instanceParser.parseBlock(data!)
            XCTAssertNotNil(instance)
            instance?.register(application: "test", scopes: [.read, .write, .follow], appURL: nil) { (registration, error) in
                XCTAssertNotNil(registration)
                XCTAssertNil(error)
                
                registrationExpecation.fulfill()
            }
        }
        
        wait(for: [registrationExpecation], timeout: 10)
    }
    
    func testApplicationRegistrationFailure() {
        let params = Params()
        let registrationExpecation = expectation(description: "registration")
        
        let client = Client(url: URL(string: params.instance)!)
        
        let instanceTask = Instance.getInstanceTask
        let instanceParser = JSONParser<Instance>()
        
        client.perform(task: instanceTask) { (data, error) in
            let instance = try? instanceParser.parseBlock(data!)
            
            XCTAssertNotNil(instance)
            instance?.register(application: "test", redirectURIs: ["test"], scopes: [.read], appURL: nil) { (registration, error) in
                XCTAssertNotNil(error)
                XCTAssertNil(registration)
                
                registrationExpecation.fulfill()
            }
        }
        
        wait(for: [registrationExpecation], timeout: 10)
    }
    
}
