//
//  BigFaceView.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//

import SwiftUI

struct BigFaceView: View {

    @State var pos: CGSize
    @State var position: CGSize
    
    private let Eye: some View = {
        Circle()
            .foregroundColor(Color.black)
    } ()
    
    var body: some View {
        GeometryReader { geo in
            let scale = min(geo.size.width, geo.size.height) / 270
            let leftScale = (position).width < 0 ? 1 + scaleSpeed(position.width, scale) : 1
            let rightScale = position.width > 0 ? 1 - scaleSpeed(position.width, scale) : 1
            
            VStack {
                Spacer()
                HStack {
                    
                    // Left eye.
                    Eye
                        .frame(width: size.0 * scale, height: size.0 * scale)
                        .scaleEffect(leftScale)

                    Spacer()
                    // Right eye.
                    Eye
                        .frame(width: size.0 * scale, height: size.0 * scale)
                        .scaleEffect(rightScale)
                }
                .frame(width: size.1 * scale, height: size.0 * scale)
                .offset(x: xOffsetSpeed(position.width, 30.0), y: yOffsetSpeed(position.height, 30.0))

                // Mouth
                ZStack(alignment: .bottom) {
                    Image("mouth").resizable()
                        .frame(
                            width: mouth.0 * scale - (position.width > 0 ? (15 / 105 * position.width) : 0),
                            height: mouth.1 * scale)
                    Image("tongue").resizable()
                        .frame(width: tongue.0 * scale, height: tongue.1 * scale + (position.height < 0 ? (4.0 / 93.0) * position.height : 0))
                        .scaleEffect(1.0 - (position.width > 0 ? (0.4 / 105 * position.width) : 0))
                        
                }
                .offset(x: xOffsetSpeed(position.width, 34.0), y: yOffsetSpeed(position.height, 35.0))
                    
                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .gesture(
                DragGesture()
                    .onChanged({ (value) in
                        if abs(xOffsetSpeed(value.translation.width + self.pos.width, 30.0)) <= 30 * scale {
                            self.position.width = value.translation.width + self.pos.width
                        }
                        
                        if abs(yOffsetSpeed(value.translation.height + self.pos.height, 30.0)) <= 30 * scale {
                            self.position.height = value.translation.height + self.pos.height
                        }
                    })
                    .onEnded({ (value) in
                        self.pos = self.position
                    })
            )
        }
    }
    
    private let leftEye: (CGFloat, CGFloat) = (61, 133.62)
    private let rightEye: (CGFloat, CGFloat) = (127, 132.62)
    private let mouth: (CGFloat, CGFloat) = (35, 19)
    private let tongue: (CGFloat, CGFloat) = (16, 8)
    private let size: (CGFloat, CGFloat) = (19, 85)
    private let limit: CGFloat = 30
    
    func xOffsetSpeed(_ distance: CGFloat, _ baseDistance: CGFloat) -> CGFloat {
        let rate: CGFloat = baseDistance / 105.0
        return rate * distance
    }
    
    func yOffsetSpeed(_ distacne: CGFloat, _ baseDistance: CGFloat) -> CGFloat {
        let rate: CGFloat = baseDistance / 93.0
        return rate * distacne
    }
    
    func scaleSpeed(_ distance: CGFloat, _ scale: CGFloat) -> CGFloat {
        let rate: CGFloat = 0.3 / (105.0 * scale)
        return rate * distance
    }
}

struct BigFacePreView: View {
    private var pod: CGSize = CGSize()
    
    var body: some View {
        BigFaceView(pos: pod, position: pod)
    }
}

//struct BigFaceView_Previews: PreviewProvider {
////    @State private var po: CGSize = .zero
//    static var previews: some View {
//        @State private var po: CGSize = .zero
//        BigFaceView(pos: $po, position: $po)
////        BigFaceView()
////            .previewLayout(.fixed(width: 270, height: 270))
////        BigFaceView()
////            .previewLayout(.fixed(width: 400, height: 400))
////        BigFaceView()
////            .previewLayout(.fixed(width: 400, height: 200))
//    }
//}
