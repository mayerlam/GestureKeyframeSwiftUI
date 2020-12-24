//
//  PathView.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

/// Generate an automatically resized View based on a given path
struct PathView: View {
    var path: Path
    
    var body: some View {
        VStack {
            path
                .stroke(Color.purple, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .miter, miterLimit: 0))
        }
        .frame(width: path.boundingRect.width, height: path.boundingRect.height, alignment: .center)
        .offset(x: -path.boundingRect.minX, y: -path.boundingRect.minY)
    }
}
