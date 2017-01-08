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
    
    /* var app:UIApplication? = nil
    var mediaController:MediaController? = nil
    var mediaView:UIView? = nil */
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        /* app = UIApplication.shared
        mediaController = UIApplication.shared.delegate as! MediaController
        mediaView = mediaController?.view */
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
/*
    func testAccessServer() {
     XCTAssertTrue(MediaController.pingServer() == 200)
    }
    
    func testApp() {
        XCTAssertNotNil(app, "Can't find UIApplication instance")
    }

    func testMediaController() {
        XCTAssertNotNil(mediaController, "Can't find MediaController instance")
    }
    
    func testMediaView() {
        XCTAssertNotNil(mediaView, "Can't find MediaView instance")
    }
    
    func testPlayMusic() {
        mediaController?.listSound.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.top)
    } */
}
