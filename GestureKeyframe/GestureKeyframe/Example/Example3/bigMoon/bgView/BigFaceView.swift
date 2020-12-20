//
//  BigFaceView.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//

import SwiftUI

struct BigFaceView: View {

    @Binding var gesture: CGSize

    private let eye: some View = {
        Circle()
            .foregroundColor(Color.black)
    } ()
    
    private let cheek: some View = {
        Circle()
            .foregroundColor(Color(UIColor.init(hex: 0x0A97FB)))
    } ()
    
    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width, geo.size.height) / 270
            Keyframe(gesture, timeLine: keyPoint, curveType: .line) { out in

                let leftEye = BFKFParameters.leftEye
                let rightEye = BFKFParameters.rightEye
                let mouth = BFKFParameters.mouth
                let tongue = BFKFParameters.tongus

                VStack {
                    Spacer()
                    HStack {
                        // Left eye.
                        eye
                            .frame(width: size.0 * scale, height: size.0 * scale)
                            .scaleEffect(out(leftEye.scale!, .x))
                        Spacer()
                        // Right eye.
                        eye
                            .frame(width: size.0 * scale, height: size.0 * scale)
                            .scaleEffect(out(rightEye.scale!, .x))
                    }
                    .frame(width: size.1 * scale, height: size.0 * scale)
                    .offset(x: out(rightEye.xOffset!, .x), y: out(rightEye.yOffset!, .y))

                    //  Mouth stack
                    ZStack(alignment: .bottom) {
                        Image("mouth").resizable()
                            .frame(
                                width: out(mouth.width!, .x),
                                height: 19 * scale)
                        Image("tongue").resizable()
                            .frame(
                                width: 16 * scale,
                                height: out(tongue.height!, .y)
                            )
                            .scaleEffect(out(tongue.scale!, .y))
                    }
                    .offset(x: out(mouth.xOffset!, .x), y: out(mouth.yOffset!, .y))

                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
    
    private let keyPoint = [
        CGPoint(x: -102.00, y: -93.00),
        CGPoint(x: 0.00, y: 0.00),
        CGPoint(x: 108, y: 93.00)
    ]
    
    private let size: (CGFloat, CGFloat) = (19, 85)
}

struct BigFacePreView: View {
    
    @State private var pod: CGSize = CGSize()
    
    var body: some View {
        BigFaceView(gesture: $pod)
    }
}

struct BigFacePreView_PreView: PreviewProvider {
    
    static var previews: some View {
        BigFacePreView()
    }
}
