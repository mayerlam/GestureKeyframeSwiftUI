//
//  BasePath.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI


class BasePath {
    var nodes: [CGPoint]?
    
    public var path: Path? {
        if self._path == nil {
            self._path = self.delegate?.buildPath(nodes!)
        }
        return self._path
    }
    
    /// Every `subClass` should setting this member,
    /// if you want get the `Path` by the given nodes.
    var delegate: CurvePathDelegate?
    
    /// Get the path begin point
    lazy var beginPoint: CGPoint? = {
        guard let pt = self.path else {
            return nil
        }
        
        let tinySegment = pt.trimmedPath(from: 0, to: 0.001)
        return CGPoint(x: tinySegment.boundingRect.midX, y: tinySegment.boundingRect.midY)
    } ()
    
    /// Get the path end point
    lazy var endPoint: CGPoint? = {
        guard let pt = self.path else {
            return nil
        }
        let tinySegment = pt.trimmedPath(from: 0.999, to: 1)
        return CGPoint(x: tinySegment.boundingRect.midX, y: tinySegment.boundingRect.midY)
    } ()
    
    private var _path: Path?
    
    ///
    /// - Parameter nodes: the given nodes
    init(_ nodes: [CGPoint]) {
        self.nodes = nodes
    }
    
    ///
    /// - Parameter path: the given path
    init(_ path: Path) {
        self._path = path
    }

    /// According to the given percent
    /// calculate the X coordinate
    ///
    /// - Parameter pect: The given pect
    /// - Returns: Calculated x coordinate
    func percent2X(_ pect: CGFloat) -> CGFloat? {
        return curPoint(pect: pect)?.x
    }
    
    func curPoint(pect: CGFloat, precision: CGFloat = 0.001) -> CGPoint? {
        guard let pt = self.path else {
            return nil
        }
        
        /// As the precision, it should be a very small number.
        /// Even you give a bigger number, the program still run ok
        /// But it always return `0`
        guard precision < 1 else {
            return .zero
        }
        
        let from: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1 - precision) : pect
        let to: CGFloat = pect > CGFloat(1 - precision) ? CGFloat(1) : pect + precision
        let tinySegment = pt.trimmedPath(from: from, to: to)
        return CGPoint(x: tinySegment.boundingRect.midX, y: tinySegment.boundingRect.midY)
    }

    /// According to the given percent,
    /// calculate the Y coordinate
    ///
    /// - Parameters:
    ///   - pect: The given pect
    ///   - precision: Differential quantities
    /// - Returns: Y coordinate
    func curValue(pect: CGFloat, precision: CGFloat = 0.001) -> CGFloat? {
        return curPoint(pect: pect, precision: precision)?.y
    }
    
    /// According to the given percent
    /// calculate the k value
    ///
    /// - Parameters:
    ///   - pect: The given pect
    ///   - precision: Differential quantities
    /// - Returns: k value
    func curAngle(pect: CGFloat, precision: CGFloat = 0.001) -> CGFloat? {
        var weight: CGFloat = 1.00
        
        guard let pt1 = curPoint(pect: pect, precision: precision),
              var pt2 = curPoint(pect: pect + weight * precision * 10, precision: precision)
        else {
            return nil
        }
        
        if pt1 == pt2 {
            weight = -1
            pt2 = curPoint(pect: pect + weight * precision * 10, precision: precision)!
        }
        
        if pt1 == pt2 {
            return CGFloat.nan
        }
        
        let k = (pt2.y - pt1.y) / (pt2.x - pt1.x)
        return CGFloat(atan(k))
    }
}

extension BasePath {
    /**
     *  Warning:
     *  The following methods are available
     *  if and only if the given path is a single-valued function.
     *
     *  Even if not, these function still runable,
     *  But it won't be the result you expect.
     */
    
    /// According to the given X coordinate,
    /// calculate the percentage from the start point of path
    ///
    /// - Parameter curX: The given X coordinate
    /// - Returns: Calculated percentage value
    func x2Percent(_ curX: CGFloat) -> CGFloat {
        
        guard let beginX = self.beginPoint?.x, let endX = self.endPoint?.x else {
            return 0
        }
        
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
        let pect = x2Percent(curX)
        return curValue(pect: pect, precision: precision)
    }
    
    /// According the given X coordinate
    /// calculate the k value
    ///
    /// - Parameters:
    ///   - curX: The given X coordinate
    ///   - precision: Differential quantities
    /// - Returns: k value
    func curAngle(x curX: CGFloat, precision: CGFloat = 0.001) -> CGFloat? {
        let pect = x2Percent(curX)
        return curAngle(pect: pect, precision: precision)
    }
}
