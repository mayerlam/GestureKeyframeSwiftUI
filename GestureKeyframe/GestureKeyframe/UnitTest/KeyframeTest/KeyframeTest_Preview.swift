//
//  KeyframeTest_Preview.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

struct KeyframeTestView: View {

    @State var x: CGFloat = .zero
    let curve = PolylineCurve(testNodes3)
    let valus: [CGFloat] = testNodes3.map { $0.y }
    
    var body: some View {
        
        Keyframe((x / 100) * (testNodes3.last!.x - testNodes3.first!.x) + 100, timeLine: Set(testNodes3.map { $0.x }), curveType: .line) { value in
            VStack {
                Text("\(x), \(value([200, 300, 150, 350, 300, 400]))")
                ShowThePath(celsius: $x, curve: curve) { _ in
                    value([200, 300, 150, 350, 300, 400])
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
