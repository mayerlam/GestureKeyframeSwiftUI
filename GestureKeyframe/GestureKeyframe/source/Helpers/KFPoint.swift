//
//  KFPoint.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import UIKit

public struct KFPoint: Hashable {
    private var point: CGPoint
    
    var x: CGFloat {
        point.x
    }
    
    var y: CGFloat {
        point.y
    }
    
    init(x: CGFloat, y: CGFloat) {
        self.point = CGPoint(x: x, y: y)
    }
    
    init(x: Int, y: Int) {
        self.point = CGPoint(x: x, y: y)
    }
    
    init(x: Double, y: Double) {
        self.point = CGPoint(x: x, y: y)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
    }
}
