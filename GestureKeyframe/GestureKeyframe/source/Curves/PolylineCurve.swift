//
//  PolylineCurve.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

/// The poly-line time curve that conforms TimeLineCurve
/// In fact, it's a piecewise function
/// and each sub-functions are linear function
class PolylineCurve: BasePath, CurvePathDelegate {

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
                path.addLine(to: nodes[i])
            }
        }
        return path
    }
}
