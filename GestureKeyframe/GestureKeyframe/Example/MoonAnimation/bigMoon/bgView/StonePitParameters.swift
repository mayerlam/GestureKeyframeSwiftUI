//
//  StonePitParameters.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//


import SwiftUI

struct StonePitParameters {
    struct member {
        let size: CGFloat
        let position: (CGFloat, CGFloat)
    }
    
    static let scale: CGFloat = 1.0
    static let pits = [
        member(
            size: 40,
            position: (144, 43.54)
        ),
        member(
            size: 26,
            position: (113, 35.54)
        ),
        member(
            size: 34,
            position: (24, 82.54)
        ),
        member(
            size: 50,
            position: (169, 199.54)
        ),
        member(
            size:50,
            position: (-8, 164.54)
        ),
        member(
            size: 34,
            position: (57, 191.54)
        )
    ]
}
