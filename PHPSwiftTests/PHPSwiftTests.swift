//
//  PHPSwiftTests.swift
//  PHPSwiftTests
//
//  Created by 吕文翰 on 15/10/5.
//  Copyright © 2015年 JohnLui. All rights reserved.
//

import XCTest
@testable import PHPSwift

class PHPSwiftTests: XCTestCase {
    
    var variable: PHP$!
    
    override func setUp() {
        super.setUp()
        self.variable = nil
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInt() {
        self.variable = 0
        XCTAssertEqual(self.variable, 0)
        XCTAssertTrue(self.variable == 0)
        XCTAssertTrue(0 == self.variable)
    }
    func testString() {
        self.variable = "PHP"
        XCTAssertEqual(self.variable, "PHP")
        XCTAssertTrue(self.variable == "PHP")
        XCTAssertTrue("PHP" == self.variable)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
