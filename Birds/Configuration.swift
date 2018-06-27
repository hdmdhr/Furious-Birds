//
//  Configuration.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/15.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import CoreGraphics

struct LevelsData {
    
    static var levelsDictionary = [String : Any]()
    
}

struct ZPosition {
    static let background: CGFloat = 0
    static let obstacles: CGFloat = 1
    static let bird: CGFloat = 2
    static let hudBackground: CGFloat = 10
    static let hudLabel: CGFloat = 11
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all = UInt32.max
    static let edge: UInt32 = 0x1
    static let bird: UInt32 = 0x1 << 1
    static let block: UInt32 = 0x1 << 2
    static let enemy: UInt32 = 0x1 << 3
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

extension CGSize {
    static public func / (left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width/right, height: left.height/right)
    }
    
    static public func * (left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(width: left.width * right, height: left.height * right)
    }
}

extension CGVector {
    
    static public func * (left: CGVector, right: CGFloat) -> CGVector {
        return CGVector(dx: left.dx * right, dy: left.dy * right)
    }
    
}
