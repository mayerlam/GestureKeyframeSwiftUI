//
//  Example2.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/20.
//

import SwiftUI

/// Example2: Cards Interface
struct Example2: View {
    
    let keyFrames: [CGPoint] = []
    var body: some View {
        KeyframeTestView()
    }
}

struct Example2_Previews: PreviewProvider {
    static var previews: some View {
        Example2()
    }
}
