//
//  PHP$.swift
//  PHPSwift
//
//  Created by 吕文翰 on 15/10/5.
//  Copyright © 2015年 JohnLui. All rights reserved.
//

import Foundation
enum PHP$Type {
    case Float, String, Array, Dictionary, Unknown
}

public struct PHP$ {
    private var data: AnyObject!
    private var array: [PHP$]!
    private var dictionary: [String: PHP$]!
    private var type: PHP$Type {
        get {
            switch self.getData() {
            case _ as Float:
                return .Float
            case _ as String:
                return .String
            case _ as [PHP$]:
                return .Array
            case _ as [String: PHP$]:
                return .Dictionary
            default:
                return .Unknown
            }
        }
    }
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
                return a.sort({ $0.0 < $1.0 }).description
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
    func getFloat() -> Float! {
        if self.type != .Float {
            return nil
        }
        return self.getData() as! Float
    }
    func getString() -> String! {
        if self.type != .String {
            return nil
        }
        return self.getData() as! String
    }
    func getArray() -> [PHP$] {
        if self.type != .Array {
            return [PHP$]()
        }
        return self.getData() as! [PHP$]
    }
    func getDictionary() -> [String: PHP$] {
        if self.type != .Dictionary {
            return [String: PHP$]()
        }
        return self.getData() as! [String: PHP$]
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

extension PHP$: IntegerArithmeticType {
    public static func addWithOverflow(lhs: PHP$, _ rhs: PHP$) -> (PHP$, overflow: Bool) {
        return (lhs, false)
    }
    public static func subtractWithOverflow(lhs: PHP$, _ rhs: PHP$) -> (PHP$, overflow: Bool) {
        return (lhs, false)
    }
    public static func multiplyWithOverflow(lhs: PHP$, _ rhs: PHP$) -> (PHP$, overflow: Bool) {
        return (lhs, false)
    }
    public static func divideWithOverflow(lhs: PHP$, _ rhs: PHP$) -> (PHP$, overflow: Bool) {
        return (lhs, false)
    }
    public static func remainderWithOverflow(lhs: PHP$, _ rhs: PHP$) -> (PHP$, overflow: Bool) {
        return (lhs, false)
    }
    public func toIntMax() -> IntMax {
        return INT64_MAX
    }
}

public func +(lhs: PHP$, rhs: PHP$) -> PHP$ {
    switch lhs.type {
    case .Dictionary:
        if rhs.type != .Dictionary {
            return PHP$(string: lhs.value + rhs.value)
        }
        return PHP$(dictionary: lhs.getDictionary() + rhs.getDictionary())
    case .Array:
        if rhs.type != .Array {
            return PHP$(string: lhs.value + rhs.value)
        }
        return PHP$(array: lhs.getArray() + rhs.getArray())
    case .String:
        return PHP$(string: lhs.value + rhs.value)
    case .Float:
        if rhs.type != .Float {
            return PHP$(string: lhs.value + rhs.value)
        }
        return PHP$(float: FloatLiteralType(lhs.getFloat() + rhs.getFloat()))
    case .Unknown:
        return PHP$(string: lhs.value + rhs.value)
    }
}
public func -(lhs: PHP$, rhs: PHP$) -> PHP$ {
    return lhs
}
public func *(lhs: PHP$, rhs: PHP$) -> PHP$ {
    return lhs
}
public func /(lhs: PHP$, rhs: PHP$) -> PHP$ {
    return lhs
}
public func %(lhs: PHP$, rhs: PHP$) -> PHP$ {
    return lhs
}


public func <(lhs: PHP$, rhs: PHP$) -> Bool {
    return true
}
public func <=(lhs: PHP$, rhs: PHP$) -> Bool {
    return true
}
public func >(lhs: PHP$, rhs: PHP$) -> Bool {
    return true
}
public func >=(lhs: PHP$, rhs: PHP$) -> Bool {
    return true
}

public func +<K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V>
{
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}
