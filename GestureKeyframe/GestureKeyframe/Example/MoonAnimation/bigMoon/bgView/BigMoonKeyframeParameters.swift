//
//  BigMoonKeyframeParameters.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/-500.
//

import SwiftUI

struct BFKFParameters {
    
    struct Features {
        var xOffset: [CGFloat]?
        var yOffset: [CGFloat]?
        var width  : [CGFloat]?
        var height : [CGFloat]?
        var scale  : [CGFloat]?
    }
    static let leftEye =
        Features(
            xOffset: [-30.00, 0.00, 35.00],
            yOffset: [-30.00, 0.00, 30.00],
            // bind x
            scale  : [0.7, 1.00, 1.00]
        )
    static let rightEye =
        Features(
            xOffset: [-30.00, 0.00, 30.00],
            yOffset: [-30.00, 0.00, 30.00],
            // bind x
            scale  : [1.00, 1.00, 0.7]
        )
    static let mouth =
        Features(
            xOffset: [-35.00, 0.00, 40.00],
            yOffset: [-34.00, 0.00, 45.00],
            // bind x
            width: [35.00, 35.00, 20.00]
        )
    static let tongus =
        Features(
            xOffset: [-33.00, 0.00, 38.00],
            yOffset: [-30.00, 0.00, 40.00],
            // bind y
            height: [4.00, 8.00, 8.00],
            // bind x
            scale  : [1.00, 1.00, 0.60]
        )
    static let leftCheek =
        Features(
            xOffset: [-23.50, 0.00, 33.50],
            yOffset: [-30.00, 0.00, 30.00],
            // bind y
            width: [14.00, 14.00, 11.00],
            // bind y
            height: [14.00, 14.00, 11.00],
            // bind x
            scale  : [0.70, 1.00, 1.00]
        )
    static let rightCheek =
        Features(
            xOffset: [-33.50, 0.00, 23.50],
            yOffset: [-30.00, 0.00, 30.00],
            // bind y
            width: [14.00, 14.00, 11.00],
            // bind y
            height: [14.00, 14.00, 11.00],
            // bind x
            scale  : [1.00, 1.00, 0.70]
        )
}
