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
    func testNil() {
        self.variable = nil
        XCTAssertEqual(self.variable, nil)
        XCTAssertFalse(self.variable != nil)
        XCTAssertFalse(nil != self.variable)
    }
    func testBool() {
        self.variable = true
        XCTAssertEqual(self.variable, true)
        XCTAssertTrue(self.variable == true)
        XCTAssertTrue(true == self.variable)
        XCTAssertTrue(self.variable != false)
        XCTAssertTrue(false != self.variable)
    }
    func testArray() {
        self.variable = ["PHP", "Swift"]
        XCTAssertEqual(self.variable, ["PHP", "Swift"])
        XCTAssertTrue(self.variable == ["PHP", "Swift"])
        XCTAssertTrue(["PHP", "Swift"] == self.variable)
        XCTAssertFalse(self.variable == ["Swift", "PHP"])
        XCTAssertFalse(["Swift", "PHP"] == self.variable)
    }
    func testDictionary() {
        let dic: PHP$ = ["test": 100]
        self.variable = ["PHP": 10086, "Swift": "Hello", "dic": dic]
        XCTAssertEqual(self.variable, ["PHP": 10086, "Swift": "Hello", "dic": dic])
        XCTAssertTrue(self.variable == ["PHP": 10086, "Swift": "Hello", "dic": dic])
        XCTAssertTrue(["PHP": 10086, "Swift": "Hello", "dic": dic] == self.variable)
        XCTAssertTrue(self.variable == ["dic": dic, "Swift": "Hello", "PHP": 10086])
        XCTAssertTrue(["dic": dic, "Swift": "Hello", "PHP": 10086] == self.variable)
        XCTAssertFalse(self.variable == ["dic": dic, "PHP": 10086, "Swift": "Hello", "add": true])
        XCTAssertFalse(["dic": dic, "PHP": 10086, "Swift": "Hello", "add": true] == self.variable)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
