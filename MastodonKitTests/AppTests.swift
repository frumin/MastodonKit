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
        
        let client = UnauthenticatedClient(url: URL(string: params.instance)!)
        
        let instanceTask = Instance.GetInstanceTask()
        let registerTask = Instance.RegisterAppTask(name: "test", scopes: [.read], appURL: nil)
        
        client.perform(task: instanceTask) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            let instance = try? Instance(jsonData: data!)
            XCTAssertNotNil(instance)
            client.perform(task: registerTask, completion: { (data, error) in
                let app = try? App(jsonData: data!)
                XCTAssertNotNil(app)
                XCTAssertNil(error)
                
                registrationExpecation.fulfill()
            })
        }
        
        wait(for: [registrationExpecation], timeout: 10)
    }
    
}
