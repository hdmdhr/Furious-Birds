//
//  Configuration.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/15.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import CoreGraphics

struct ZPosition {
    static let background: CGFloat = 0
    static let obstacles: CGFloat = 1
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all = UInt32.max
    static let edge: UInt32 = 0x1
    static let bird: UInt32 = 0x1 << 1
    static let block: UInt32 = 0x1 << 2
}

extension CGPoint {
    
    static public func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static public func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
}
