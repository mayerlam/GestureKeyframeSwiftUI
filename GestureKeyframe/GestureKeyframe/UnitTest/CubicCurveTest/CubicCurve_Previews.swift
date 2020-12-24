//
//  CubicCurve_Previews.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

struct CubicCurve_Previews: PreviewProvider {
    static var previews: some View {
        ShowThePath(curve: CubicCurve(testNodes))
        ShowThePath(curve: PolylineCurve(testNodes))
        ShowThePath(curve: CubicCurve(testNodes2))
        ShowThePath(curve: PolylineCurve(testNodes2))
        ShowThePath(curve: CubicCurve(testNodes3))
        ShowThePath(curve: PolylineCurve(testNodes3))
    }
}
