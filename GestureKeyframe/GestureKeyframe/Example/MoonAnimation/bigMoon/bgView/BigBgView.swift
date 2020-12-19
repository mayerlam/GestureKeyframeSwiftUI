//
//  BigBgView.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//

import SwiftUI

struct BigBgView: View {
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height) - 100
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .topLeading) {
                        BigBgImage()
                        StonePitView()
                            .offset(x: speedRate(x:position.width + dragOffset.width), y: speedRate(y: position.height + dragOffset.height))
                        BigFaceView(pos: CGSize(), position: CGSize())
                    }
                    .frame(width: size, height: size, alignment: .center)
                    .clipShape(Circle())
                    Spacer()
                }

                Spacer()
            }
            .background(Color(hex: 0x151845))
        }
        .edgesIgnoringSafeArea(.all)
//        .gesture(
//            DragGesture()
//                .updating($dragOffset, body: { (value, state, transaction) in
//                    state = value.translation
//                })
//                .onEnded({ (value) in
//                    self.position.height += value.translation.height
//                    self.position.width += value.translation.width
//                })
//        )
    }
    
    func speedRate(x distance: CGFloat) -> CGFloat {
        return distance * 0.1
    }
    
    func speedRate(y distance: CGFloat) -> CGFloat {
        return distance * 0.1
    }
}

struct BigBgView_Previews: PreviewProvider {
    static var previews: some View {
        BigBgView()
    }
}
