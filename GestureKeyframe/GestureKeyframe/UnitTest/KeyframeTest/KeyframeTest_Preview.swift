//
//  KeyframeTest_Preview.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

struct KeyframeTestView: View {

    @State var x: CGFloat = .zero
    let curve = CubicCurve(testNodes3)
    let valus: [CGFloat] = testNodes3.map { $0.y }
    
    var body: some View {
        
        Keyframe(bindPect: x / 100, timeLine: Set(testNodes3.map { $0.x }), curveType: .Cubic) { value in
            VStack {
                ShowThePath(celsius: $x, curve: curve) { _ in
                    value(testNodes3.map { $0.y })
                }
            }
        }
    }
}

struct KeyframeTest_Previews: PreviewProvider {
    static var previews: some View {
        KeyframeTestView()
    }
}
