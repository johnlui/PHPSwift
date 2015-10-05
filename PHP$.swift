//
//  PHP$.swift
//  PHPSwift
//
//  Created by 吕文翰 on 15/10/5.
//  Copyright © 2015年 JohnLui. All rights reserved.
//

import Foundation

public struct PHP$ {
    var data: AnyObject!
    var value: String {
        get {
            // Int, Bool
            if let _ = self.data as? Int {
                return self.data.description
            }
            // String
            if let _ = self.data as? String {
                return self.data.description
            }
            // Array
            if let _ = self.data as? [PHP$] {
                print("array: \(self.data)")
                return self.data.description
            }
            // Dictionary
            if let _ = self.data as? [String: PHP$] {
                print("dictionary: \(self.data)")
                return self.data.description
            }
            print("==: \(self.data)")
            return ""
        }
    }
    init(int: IntegerLiteralType) {
        self.data = int
    }
    init(float: FloatLiteralType) {
        self.data = float
    }
    init(string: StringLiteralType) {
        self.data = string
    }
    init(nilValue: ()) {
        self.data = nil
    }
    init(bool: BooleanLiteralType) {
        self.data = bool
    }
    init(array: [PHP$]) {
        self.data = array.description
    }
    init(dic: [String: PHP$]) {
        self.data = dic.description
    }
}

extension PHP$: IntegerLiteralConvertible {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(int: value)
    }
}
extension PHP$: FloatLiteralConvertible {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(float: value)
    }
}
extension PHP$: StringLiteralConvertible {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = ExtendedGraphemeClusterLiteralType
    public init(stringLiteral value: StringLiteralType) {
        self.init(string: value)
    }
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(string: "\(value)")
    }
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(string: value)
    }
}
extension PHP$: NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self.init(nilValue: nilLiteral)
    }
}
extension PHP$: BooleanLiteralConvertible {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(bool: value)
    }
}
extension PHP$: ArrayLiteralConvertible {
    public init(arrayLiteral elements: PHP$...) {
        self.init(array: elements)
    }
}
extension PHP$: DictionaryLiteralConvertible {
    public init(dictionaryLiteral elements: (String, PHP$)...) {
        self.init(dic: elements.reduce([String : PHP$]()){(dictionary: [String : PHP$], element:(String, PHP$)) -> [String : PHP$] in
            var d = dictionary
            d[element.0] = element.1
            return d
            })
    }
}

extension PHP$: Equatable {}
public func ==(lhs: PHP$, rhs: PHP$) -> Bool {
    return lhs.value == rhs.value
}