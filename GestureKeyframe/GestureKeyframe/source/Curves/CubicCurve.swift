//
//  CubicCurve.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

/// Build
class CubicCurve: BasePath, CurvePathDelegate {
    
    override init(_ nodes: [CGPoint]) {
        super.init(nodes)
        self.delegate = self
    }
    
    func buildPath(_ nodes: [CGPoint]) -> Path {
        var path = Path()
        
        for i in 0..<nodes.count {
            if i == 0 {
                path.move(to: nodes[i])
            } else {
                let centerX = (nodes[i].x + nodes[i-1].x) / 2
                let control1 = CGPoint(
                    x: centerX,
                    y: nodes[i - 1].y
                )
                
                let control2 = CGPoint(
                    x: centerX,
                    y: nodes[i].y
                )
                
                path.addCurve(to: nodes[i], control1: control1, control2: control2)
            }
        }
        return path
    }
}
