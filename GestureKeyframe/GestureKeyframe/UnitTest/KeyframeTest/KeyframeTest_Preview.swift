//
//  KeyframeTest_Preview.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

struct KeyframeTestView: View {

    @State var x: CGFloat = .zero
    let curve = CubicCurve(testNodes)
    
    var body: some View {
//
//        Keyframe(bindPect: x / 100, timeLine: Set(testNodes.map { $0.x }), curveType: .Cubic) { value in
//            VStack {
//                ShowThePath(celsius: $x, curve: curve) { _ in
//                    value(testNodes.map { $0.y })
//                }
//            }
//        }
        
        Keyframe(bindPect: x / 100, path: curve.path!) { value in
            VStack {
                ShowThePath(celsius: $x, curve: curve) { _ in value() }
            }
        }
    }
}

struct KeyframeTest_Previews: PreviewProvider {
    static var previews: some View {
        KeyframeTestView()
    }
}
