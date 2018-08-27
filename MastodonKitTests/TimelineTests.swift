//
//  TimelineTests.swift
//  MastodonKitTests
//
//  Created by Tom Zaworowski on 8/19/18.
//  Copyright © 2018 Acidbits. All rights reserved.
//

import XCTest

class TimelineTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHomeTimeline() {
        let params = Params()
        let timelineExpectation = XCTestExpectation(description: "auth")
        
        let client = Client(url: URL(string: params.instance)!)
        
        let instanceTask = Instance.getInstanceTask
        let instanceParser = JSONParser<Instance>()
        
        client.perform(task: instanceTask) { (data, error) in
            let instance = try? instanceParser.parseBlock(data!)
            instance?.register(application: "MastodonKit", scopes: [.read]) { (registration, error) in
                guard let registration = registration else {
                    XCTAssert(false)
                    timelineExpectation.fulfill()
                    return
                }
                Account.authenticate(user: params.user, password: params.pass, instance: instance!, app: registration, completion: { (account, authError) in
                    XCTAssertNil(authError)
                    XCTAssertNotNil(account)
                    
                    Timeline.getHome(for: account!, instance: instance!, completion: { (timeline, error) in
                        XCTAssertNil(error)
                        XCTAssertNotNil(timeline)
                        
                        timelineExpectation.fulfill()
                    })
                })
            }
        }
        
        wait(for: [timelineExpectation], timeout: 30)
    }
    
}
