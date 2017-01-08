//
//  SmartMediaTests.swift
//  SmartMediaTests
//
//  Created by Soulier Antoine on 07/01/2017.
//  Copyright © 2017 antoine.soulier. All rights reserved.
//

import XCTest
@testable import SmartMedia


class SmartMediaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMultiply() {
        XCTAssertTrue(MediaController.multiply(a:10, b:2) == 20)
    }
    
    
}
