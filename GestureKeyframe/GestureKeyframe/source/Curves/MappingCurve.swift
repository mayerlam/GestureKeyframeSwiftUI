//
//  MappingCurve.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/25.
//

import SwiftUI

//TODO: 注释
class MappingCurve: PolylineCurve {
    
    var map: (CGFloat) -> CGFloat
    
    override init(_ nodes: [CGPoint]) {
        fatalError("This class dost not support the current initial method")
    }

    init(_ map: @escaping (CGFloat) -> CGFloat, _ preViewRange: ClosedRange<CGFloat>? = nil, _ delta: CGFloat = 0.1) {
        self.map = map
        var points: [CGPoint] = []
        if let pVR = preViewRange {
           points = MappingCurve.takeSample(map, pVR, delta)
        }
        
        super.init(points)
    }
    
    //TODO: 注释
    /// 更新路径
    /// - Parameters:
    ///   - viewRange:
    ///   - delta:
    /// - Returns:
    func updatePath(_ viewRange: ClosedRange<CGFloat>, _ delta: CGFloat = 0.1) -> Path? {
        self.nodes = MappingCurve.takeSample(self.map, viewRange, delta)
        return self.path
    }
    
    //TODO: 注释
    /// 取样
    /// - Parameters:
    ///   - viewRange:
    ///   - delta:
    /// - Returns:
    static func takeSample(_ map: @escaping (CGFloat) -> CGFloat, _ viewRange: ClosedRange<CGFloat>, _ delta: CGFloat = 0.1) -> [CGPoint] {
        var pts: [CGPoint] = []
        
        var leftBound = viewRange.lowerBound
        leftBound += delta
        
        while leftBound < viewRange.upperBound {
            pts.append(CGPoint(x: leftBound, y: map(leftBound)))
            leftBound += delta
        }
        return pts
    }
}
