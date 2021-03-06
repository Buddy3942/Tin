//
//  TVector2.swift
//  Tin
//
//  Created by Loren Olson on 10/3/16.
//  Created at the School of Arts, Media and Engineering,
//  Herberger Institute for Design and the Arts,
//  Arizona State University.
//  Copyright (c) 2017 Arizona Board of Regents on behalf of Arizona State University
//

import Foundation

/**
 A structure to represent a two dimensional vector.
 */
public struct TVector2 {
    public var x: CGFloat
    public var y: CGFloat
    
    public var magnitude: CGFloat {
        get {
            return sqrt( x * x + y * y )
        }
        set {
            normalize()
            x = x * newValue
            y = y * newValue
        }
    }
    
    // MARK: - Initializers
    
    public init( x: CGFloat, y: CGFloat ) {
        self.x = x
        self.y = y
    }
    
    public init() {
        self.init( x: 0.0, y: 0.0 )
    }
    
    
    // MARK: - Type methods
    
    /**
     Calculate the angle, in radians, between two vectors.
     
     - Parameter v1: The first vector.
     - Parameter v2: The second vector.
     
     - Returns: (CGFloat) Result (in radians) angle between v1 and v2.
    */
    public static func angleBetween(v1: TVector2, v2: TVector2) -> CGFloat {
        var n1 = v1
        var n2 = v2
        n1.normalize()
        n2.normalize()
        let dp = dot(v1: n1, v2: n2)
        let result = acos(dp)
        //print("dp: \(dp) --- result: \(result)")
        return result
    }
    
    public static func cross(v1: TVector2, v2:TVector2) -> CGFloat {
        return v1.x * v2.y - v1.y * v2.x
    }
    
    public static func distance(v1: TVector2, v2: TVector2) -> CGFloat {
        let dx = v2.x - v1.x
        let dy = v2.y - v1.y
        return sqrt( dx * dx + dy * dy )
    }
    
    public static func dot(v1: TVector2, v2:TVector2) -> CGFloat {
        return v1.x * v2.x + v1.y * v2.y
    }

    
    
    // MARK: - Instance methods
    
    
    public func cross(v: TVector2) -> CGFloat {
        return x * v.y + y * v.x
    }
    
    public func distance(v: TVector2) -> CGFloat {
        let dx = x - v.x
        let dy = y - v.y
        return sqrt( dx * dx + dy * dy )
    }
    
    public func dot(v: TVector2) -> CGFloat {
        return x * v.x + y * v.y
    }
    
    public func heading() -> CGFloat {
        return atan2(y, x)
    }
    
    public mutating func lerp( v: TVector2, amount: CGFloat ) {
        x = x + (v.x - x) * amount
        y = y + (v.y - y) * amount
    }
    
    public mutating func limit( mag: CGFloat ) {
        normalize()
        x = x * mag
        y = y * mag
    }
    
    public mutating func normalize() {
        let mag = magnitude
        if mag != 0.0 {
            x = x / mag
            y = y / mag
        }
    }
    
    public mutating func rotate( theta: CGFloat ) {
        let temp = x
        x = x * cos(theta) - y * sin(theta)
        y = temp * sin(theta) + y * cos(theta)
    }
    
    
}


// MARK: - Operators

public func +(left: TVector2, right: TVector2) -> TVector2 {
    let x = left.x + right.x
    let y = left.y + right.y
    return TVector2(x: x, y: y)
}

public func -(left: TVector2, right: TVector2) -> TVector2 {
    let x = left.x - right.x
    let y = left.y - right.y
    return TVector2(x: x, y: y)
}

public func *(left: TVector2, right: CGFloat) -> TVector2 {
    let x = left.x * right
    let y = left.y * right
    return TVector2(x: x, y: y)
}

public func /(left: TVector2, right: CGFloat) -> TVector2 {
    let x = left.x / right
    let y = left.y / right
    return TVector2(x: x, y: y)
}
