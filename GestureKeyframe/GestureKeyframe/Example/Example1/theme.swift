//
//  theme.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/23.
//

import SwiftUI

struct Example1Theme {
    let capsuleBackgroudColor: Color
    let capsuleStokeColor: Color
    let emojiBackgroudColor: Color
    let emojiFacialFeaturesColor: Color
}

struct Themes {
    let dark =
        Example1Theme(
            capsuleBackgroudColor: Color.white.opacity(0.06),
            capsuleStokeColor: Color.white.opacity(0.06),
            emojiBackgroudColor: Color.white.opacity(0.5),
            emojiFacialFeaturesColor: Color.white
        )
    let light =
        Example1Theme(
            capsuleBackgroudColor: Color.white,
            capsuleStokeColor: Color.clear,
            emojiBackgroudColor: Color(hex: 0xEFD319),
            emojiFacialFeaturesColor: Color(hex: 0xD45E07)
        )
}
