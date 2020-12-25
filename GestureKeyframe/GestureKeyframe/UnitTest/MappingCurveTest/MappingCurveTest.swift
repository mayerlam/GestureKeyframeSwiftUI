//
//  MappingCurveTest.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/25.
//

import SwiftUI

struct MappingCurveTest: View {
    func map(_ x: CGFloat) -> CGFloat {
        return sin(x / 10) * 50
    }
    
    var body: some View {
        ShowThePathPreview(curve: MappingCurve(map, 0...100))
            .scaleEffect()
    }
}

struct MappingCurveTest_Previews: PreviewProvider {
    static var previews: some View {
        MappingCurveTest()
    }
}
