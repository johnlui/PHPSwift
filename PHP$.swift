//
//  PHP$.swift
//  PHPSwift
//
//  Created by 吕文翰 on 15/10/5.
//  Copyright © 2015年 JohnLui. All rights reserved.
//

import Foundation

public struct PHP$ {
    private var data: AnyObject!
    private var array: [PHP$]!
    private var dictionary: [String: PHP$]!
    var value: String {
        get {
            // Float, Int, Bool
            if let a = self.getData() as? Float {
                print("float: \(a)")
                return a.description
            }
            // String
            if let a = self.getData() as? String {
                print("string: \(a)")
                return a
            }
            // Array
            if let a = self.getData() as? [PHP$] {
                print("array: \(a)")
                a.forEach({ (i) -> () in
                    print(i)
                })
                return a.description
            }
            // Dictionary
            if let a = self.getData() as? [String: PHP$] {
                print("dictionary: \(a)")
                return a.description
            }
            print("==: \(self.data)")
            return ""
        }
    }
    func getData() -> Any! {
        if let _ = self.data {
            return self.data
        } else if let _ = self.array {
            return self.array
        } else if let _ = self.dictionary {
            return self.dictionary
        }
        return nil
    }
    init(data: Any!) {
        if let a = data as? AnyObject {
            self.data = a
        } else if let a = data as? [PHP$] {
            self.array = a
        } else if let a = data as? [String: PHP$] {
            self.dictionary = a
        }
    }
    init(int: IntegerLiteralType) {
        self.init(data: int)
    }
    init(float: FloatLiteralType) {
        self.init(data: float)
    }
    init(string: StringLiteralType) {
        self.init(data: string)
    }
    init(nilValue: ()) {
        self.init(data: nil)
    }
    init(bool: BooleanLiteralType) {
        self.init(data: bool)
    }
    init(array: [PHP$]) {
        self.init(data: array)
    }
    init(dictionary: [String: PHP$]) {
        self.init(data: dictionary)
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
        self.init(dictionary: elements.reduce([String : PHP$]()){(dictionary: [String : PHP$], element:(String, PHP$)) -> [String : PHP$] in
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