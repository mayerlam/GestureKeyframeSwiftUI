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
    
    var scaleX: CGFloat = 1
    
    var scaleY: CGFloat = 1
    
    var body: some View {
        VStack {
            path
                .scale(x: scaleX, y: scaleY,anchor: .topLeading)
                .stroke(Color.purple, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .miter, miterLimit: 0))
        }
        .frame(width: path.boundingRect.width * scaleX, height: path.boundingRect.height * scaleY, alignment: .center)
        .offset(x: -path.boundingRect.minX * scaleX, y: -path.boundingRect.minY * scaleY)
    }
}
