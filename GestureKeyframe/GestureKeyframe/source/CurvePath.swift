//
//  CurvePath.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/19.
//

import SwiftUI

protocol CurvePathDelegate {
    func buildPath(_ nodes: [CGPoint]) -> Path
}

class BasePath {
    var nodes: [CGPoint]
    public var path: Path? {
        if self._path == nil {
            self._path = self.delegate?.buildPath(nodes)
        }
        return self._path
    }
    
    /// Every `subClass` should setting this member,
    /// if you want get the `Path` by the given nodes.
    var delegate: CurvePathDelegate?
    
    private var _path: Path?
    
    init(_ nodes: [CGPoint]) {
        self.nodes = nodes
    }
    
    /// According to the given X coordinate,
    /// calculate the percentage from the start point of path
    ///
    /// - Parameter curX: The given X coordinate
    /// - Returns: Calculated percentage value
    func x2Percent(_ curX: CGFloat) -> CGFloat {
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
    func curValue(x curX: CGFloat, precision: CGFloat = 0.001) -> CGFloat? {
        
        guard let pt = self.path else {
            return nil
        }
        
        /// As the precision, it should be a very small number.
        /// Even you give a bigger number, the program still run ok
        /// But it always return `0`
        guard precision < 1 else {
            return 0
        }
        
        let pect = x2Percent(curX)
        let from: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1 - precision) : pect
        let to: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1) : pect + precision
        let tinySegment = pt.trimmedPath(from: from, to: to)
        return tinySegment.boundingRect.midY
    }
    
    func curAngle(x curX: CGFloat, precision: CGFloat = 0.001) -> CGFloat? {

        var weight: CGFloat = 1.00

        guard let pt1 = curValue(x: curX, precision: precision),
              var pt2 = curValue(x: curX + weight * precision * 10, precision: precision)
        else {
            return nil
        }
        
        if pt1 == pt2 {
            weight = -1
            pt2 = curValue(x: curX + weight * precision * 10, precision: precision)!
            
        }
        
        if pt1 == pt2 {
            return nil
        }
        
        let k = (pt2 - pt1) / (weight * precision * 10)
        return CGFloat(atan(k))
    }
}

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
