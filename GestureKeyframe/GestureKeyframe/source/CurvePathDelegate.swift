//
//  CurvePathDelegate.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/19.
//

import SwiftUI

/// If you want to build the path by the given nodes
protocol CurvePathDelegate {
    func buildPath(_ nodes: [CGPoint]) -> Path
}
