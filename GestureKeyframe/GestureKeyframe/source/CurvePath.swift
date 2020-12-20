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
        self._path == nil ? self.delegate?.buildPath(nodes) : self._path
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
    func getValue(x curX: CGFloat, precision: CGFloat = 0.001) -> CGFloat? {
        
        guard let pt = self.path else {
            return nil
        }
        
        /// As the precision, it should be a very small number.
        /// Even you give a bigger number, the program still run ok
        /// But it always return `0`
        guard precision < 1 else {
            return 0
        }
        
        let pect = getPect(curX)
        let from: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1 - precision) : pect
        let to: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1) : pect + precision
        let tinySegment = pt.trimmedPath(from: from, to: to)
        return tinySegment.boundingRect.midY
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
