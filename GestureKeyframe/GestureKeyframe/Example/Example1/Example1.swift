//
//  Example1.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/20.
//

import SwiftUI

let timeLine: [CGFloat] = [0, 60, 110, 136]
let keys: [CGFloat] = [0, 9.96, 3.29, 0]
let cs: [CGFloat] = [1, 1.1, 1.03, 1]
let co: [CGFloat] = [0, 0, 0, 1]
let sc: [CGFloat] = [1, 1, 1, 26.3]

struct Example1: View {
    
    @State var scrollOffset: CGFloat = .zero
    
    let containerRate: CGFloat = 1.7
    var body: some View {

        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let width: CGFloat = (size / 4.0) * containerRate
            let height = size / 2
            let padding = geo.size.width / 2.0 - width
            
            Keyframe(scrollOffset, timeLine: timeLine) { f in
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 44, height: 44)
                        .foregroundColor(Color(hex: 0xD45E07).opacity(Double(f(co))
                        ))
                        .scaleEffect(f(sc))
                    
                    Example1CapsuleBg()
                        .frame(width: width * 2, height: height, alignment: .center)
                    
//                    Example1ScrollView(scrollOffset: $scrollOffset, xScale: f(cs), xAngle: Angle(degrees: Double(f(keys))))
//                        .frame(width: geo.size.width)
                    ScrollViewReader { sv in
                        ScrollViewOffset(.horizontal, showsIndicators: false) {
                            scrollOffset = -$0
                        } content: {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: width)
                                    .foregroundColor(Color.clear)

                                // 顶层动态图形
                                Example1CapsuleTemplate(
                                    strokeColor : Color(hex: 0xEFD319).opacity(0.12),
                                    strokerWidth: 2,
                                    color       : Color.white
                                )
                                .frame(width: width)
                                .rotationEffect(Angle(degrees: Double(f(keys)) ))
                                .scaleEffect(f(cs))

                                Rectangle()
                                    .frame(width: width)
                                    .foregroundColor(Color.clear)
                            }
                            .padding(padding)
                        }
                    }
                }
            }
            
        }
        .background(Color(hex: 0x3B3B3B))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Example1_Previews: PreviewProvider {
    static var previews: some View {
        Example1()
        Example1CapsuleTemplate(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: .blue)
            .previewLayout(.fixed(width: 300, height: 100))
        Example1CapsuleTemplate(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: .blue)
            .previewLayout(.fixed(width: 159.7, height: 187.3))
    }
}
