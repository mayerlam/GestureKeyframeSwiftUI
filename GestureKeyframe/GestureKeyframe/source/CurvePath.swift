//
//  CurvePath.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/19.
//

import SwiftUI

/// According to the given nodes, make a path
protocol CurvePath {
    var nodes: [CGPoint] {set get}
    var path: Path { set get}
    static func buildPath(_ nodes: [CGPoint]) -> Path
}


extension CurvePath {
    
    /// According to the given X coordinate,
    /// calculate the percentage from the start point of path
    ///
    /// - Parameter curX: The given X coordinate
    /// - Returns: Calculated percentage value
    func getPect(_ curX: CGFloat) -> CGFloat {
        guard let beginNode = self.nodes.first else {
            return 0
        }
        let endNode = self.nodes.last!
        let beginX = beginNode.x
        let endX = endNode.x
        let length = endX - beginX
        let delta = curX - beginX
        
        return delta < 0 ? 0 : ( delta > (endX - beginX) ? 1 : delta / length)
    }
    
    /// According to the given X coordinate,
    /// calculate the Y coordinate
    ///
    /// - Parameters:
    ///   - curX: The given X coordinate
    ///   - precision: Differential quantities
    /// - Returns: Y coordinate
    func getValue(x curX: CGFloat, precision: CGFloat = 0.001) -> CGFloat {
        // As the precision, it should be a very small number.
        guard precision < 1 else {
            return 0
        }
        
        let pect = getPect(curX)
        let from: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1 - precision) : pect
        let to: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1) : pect + precision
        let tinySegment = path.trimmedPath(from: from, to: to)
        return tinySegment.boundingRect.midY
    }
}


/// The poly-line time curve that conforms TimeLineCurve
/// In fact, it's a piecewise function
/// and each sub-functions are linear function
struct PolylineCurve: CurvePath {
    
    var path: Path
    
    var nodes: [CGPoint]
    
    init(_ nodes: [CGPoint]) {
        self.nodes = nodes
        self.path = PolylineCurve.buildPath(nodes)
    }
    
    static func buildPath(_ nodes: [CGPoint]) -> Path {
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
