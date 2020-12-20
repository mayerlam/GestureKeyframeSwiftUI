//
//  StonePitView.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//

import SwiftUI

struct StonePitView: View {
    var body: some View {
        GeometryReader { geometry in
            let scale = min(geometry.size.width, geometry.size.height) / 270
            
            ZStack(alignment: .topLeading) {
                ForEach(0..<StonePitParameters.pits.count) { i in
                    Image("stonePit").resizable()
                        .frame(width: StonePitParameters.pits[i].size * scale, height: StonePitParameters.pits[i].size * scale, alignment: .topLeading)
                        .offset(x: StonePitParameters.pits[i].position.0 * scale, y: StonePitParameters.pits[i].position.1 * scale)
                }
            }
        }
    }
}

struct StonePitView_Previews: PreviewProvider {
    static var previews: some View {
        StonePitView()
            .previewLayout(.fixed(width: 400, height: 400))
        StonePitView()
            .previewLayout(.fixed(width: 270, height: 270))
    }
}
