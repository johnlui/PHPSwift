//
//  IntTests.swift
//  PHPSwift
//
//  Created by 吕文翰 on 15/10/7.
//  Copyright © 2015年 JohnLui. All rights reserved.
//

import XCTest
@testable import PHPSwift

class IntTests: PHPSwiftBaseTests {
    
    func testInit() {
        self.variable = 0
        XCTAssertEqual(self.variable, 0)
    }
    func testEqual() {
        self.variable = 0
        XCTAssertTrue(self.variable == 0)
        XCTAssertTrue(0 == self.variable)
        XCTAssertTrue(self.variable != 1)
        XCTAssertTrue(1 != self.variable)
    }
    func testPlus() {
        let ten: PHP$! = 10
        let ss: PHP$! = "ss"
        let array1: PHP$! = [100, "hello"]
        let array2: PHP$! = ["PHP", 10086]
        let dic1: PHP$! = ["PHP": 10086, "Swift": "Hello"]
        let dic2: PHP$! = ["10086": "PHP", "Hello": "Swift"]
        self.variable = ten + ten
        XCTAssertEqual(self.variable, 20)
        self.variable = ten + ss
        XCTAssertEqual(self.variable, "10.0ss") // Int is Float in PHP$
        self.variable = ss + ten
        XCTAssertEqual(self.variable, "ss10.0") // Int is Float in PHP$
        self.variable = ss + ss
        XCTAssertEqual(self.variable, "ssss")
        self.variable = array1 + array2
        XCTAssertEqual(self.variable, [100, "hello", "PHP", 10086])
        self.variable = dic1 + dic2
        XCTAssertEqual(self.variable, ["PHP": 10086, "Swift": "Hello", "10086": "PHP", "Hello": "Swift"])
        
        // just for crash test
        self.variable = 10086 + [100, "hello"]
        self.variable = 10086 + ["PHP": 10086, "Swift": "Hello"]
        self.variable = "hello" + [100, "hello"]
        self.variable = "hello" + ["PHP": 10086, "Swift": "Hello"]
        self.variable = [100, "hello"] + ["PHP": 10086, "Swift": "Hello"]
        self.variable = [100, "hello"] + 10086
        self.variable = [100, "hello"] + "hello"
        self.variable = ["PHP": 10086, "Swift": "Hello"] + 10086
        self.variable = ["PHP": 10086, "Swift": "Hello"] + "hello"
        self.variable = ["PHP": 10086, "Swift": "Hello"] + [100, "hello"]
    }
    
}
