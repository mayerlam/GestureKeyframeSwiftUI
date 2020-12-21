//
//  Example1.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/20.
//

import SwiftUI

struct Example1: View {
    
    @State var gesture: CGSize = .zero
    @State var position: CGSize = .zero
    @State var flag: Int = 0
    
    let containerRate: CGFloat = 1.7
    var body: some View {

        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let width: CGFloat = (size / 4.0) * containerRate
            let height = size / 2
    
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        Circle()
                            .foregroundColor(Color(hex: 0xD45E07))
                            .scaleEffect(position.width < 0 ? 0 : position.width * 2 / width)
                        HStack(alignment: .center, spacing: 0) {
                            // 左侧静态图形
                            CapsuleTemplate_ex1(
                                strokeColor : Color(hex: 0xEFD319).opacity(0.12),
                                strokerWidth: 2,
                                color       : Color.clear
                            )
                            .frame(width: width, height: height, alignment: .center)
                            // 右侧静态图形
                            CapsuleTemplate_ex1(
                                strokeColor : Color.white.opacity(0.06),
                                strokerWidth: 2,
                                color       : Color.white.opacity(0.06)
                            )
                            .frame(width: width, height: height, alignment: .center)
                        }
                        .frame(width: width * 2, height: height, alignment: .center)
                        // 顶层动态图形
                        CapsuleTemplate_ex1(
                            strokeColor : Color(hex: 0xEFD319).opacity(0.12),
                            strokerWidth: 2,
                            color       : Color.white
                        )
//                        .rotationEffect(Angle(radians: Double(position.width / width * 3)))
                        .frame(width: width, height: height, alignment: .topLeading).offset(x: -width / 2)
                        .offset(x: position.width)
//                        .animation(.spring(dampingFraction: 1, blendDuration: 1) )
                    }
                    Spacer()
                }
                Spacer()
            }
            .gesture(
                DragGesture()
                    .onChanged({
                        if $0.translation.width + self.gesture.width <= 0 {
                            self.position.width = -width - (1 / (($0.translation.width + self.gesture.width) - 1 / width))
                        } else {
                            self.position.width = $0.translation.width + self.gesture.width
                            self.position.height = $0.translation.height + self.gesture.height
                        }
//                        if $0.translation.width + self.gesture.width < 0 ||
//                            $0.translation.width + self.gesture.width > width {
//                            self.position.width = (width - 1 / $0.translation.width) + self.gesture.width
//                            self.position.height = 1 / $0.translation.height + self.gesture.height
//                        } else {
//                            self.position.width = $0.translation.width + self.gesture.width
//                            self.position.height = $0.translation.height + self.gesture.height
//                        }
                    })
                    .onEnded({ _ in
                        self.gesture = self.position
                    })
            )
        }
        .background(Color(hex: 0x3B3B3B))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CapsuleTemplate_ex1: View {
    
    var strokeColor: Color
    var strokerWidth: CGFloat
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height * 0.85)
            let height = width / 0.85
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    HStack {
                        Spacer()
                        Capsule()
                            .overlay(Capsule().stroke(strokeColor, lineWidth: strokerWidth))
                            .frame(width: height / 1.78, height: height, alignment: .center)
                            .foregroundColor(color)
                        Spacer()
                    }.frame(width: width, height: height)
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct Example1_Previews: PreviewProvider {
    static var previews: some View {
        Example1()
        CapsuleTemplate_ex1(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: .blue)
            .previewLayout(.fixed(width: 300, height: 100))
        CapsuleTemplate_ex1(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: .blue)
            .previewLayout(.fixed(width: 159.7, height: 187.3))
    }
}
