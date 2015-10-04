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
            return self.data.description
        }
    }
    init(int: IntegerLiteralType) {
        self.data = int
    }
    init(string: StringLiteralType) {
        self.data = string
    }
}

extension PHP$: IntegerLiteralConvertible {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(int: value)
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

extension PHP$: Equatable {}
public func ==(lhs: PHP$, rhs: PHP$) -> Bool {
    return lhs.value == rhs.value
}