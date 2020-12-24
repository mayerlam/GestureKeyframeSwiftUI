//
//  CubicCurve_Previews.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

struct CubicCurve_Previews: PreviewProvider {
    static var previews: some View {
        ShowThePathPreview(curve: CubicCurve(testNodes))
        ShowThePathPreview(curve: PolylineCurve(testNodes))
        ShowThePathPreview(curve: CubicCurve(testNodes2))
        ShowThePathPreview(curve: PolylineCurve(testNodes2))
        ShowThePathPreview(curve: CubicCurve(testNodes3))
        ShowThePathPreview(curve: PolylineCurve(testNodes3))
    }
}
