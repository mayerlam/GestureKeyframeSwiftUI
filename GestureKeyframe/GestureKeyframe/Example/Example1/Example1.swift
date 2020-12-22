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
    @State var scrollOffset: CGFloat = .zero
    @State var flag: Int = 0
    
    let containerRate: CGFloat = 1.7
    var body: some View {

        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let width: CGFloat = (size / 4.0) * containerRate
            let height = size / 2
            let padding = geo.size.width / 2.0 - width
            
            Keyframe(scrollOffset, timeLine: []) { f in
                VStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundColor(Color(hex: 0xD45E07).opacity(
                                    scrollOffset >= 0 ? 0.0 : abs(Double(scrollOffset)) / Double(width)
                                ))
                                .scaleEffect(
                                    scrollOffset >= 0 ? 0 :
                                        (scrollOffset) * 4 / (width)
                                )
                            HStack(alignment: .center, spacing: 0) {
                                // 左侧静态图形
                                CapsuleTemplate_ex1(
                                    strokeColor : Color(hex: 0xEFD319).opacity(0.12),
                                    strokerWidth: 2,
                                    color       : Color.clear
                                )
                                .frame(width: width, alignment: .center)
                                // 右侧静态图形
                                CapsuleTemplate_ex1(
                                    strokeColor : Color.white.opacity(0.06),
                                    strokerWidth: 2,
                                    color       : Color.white.opacity(0.06)
                                )
                                .frame(width: width, alignment: .center)
                            }
                            .frame(width: width * 2, height: height, alignment: .center)
                            
                            ScrollViewReader { sv in
                                ScrollViewOffset(.horizontal, showsIndicators: false) {
                                    scrollOffset = $0
                                } content: {
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .frame(width: width)
                                            .foregroundColor(Color.clear)
                                            .id(0)
                                        
                                        // 顶层动态图形
                                        CapsuleTemplate_ex1(
                                            strokeColor : Color(hex: 0xEFD319).opacity(0.12),
                                            strokerWidth: 2,
                                            color       : Color.white
                                        )
                                        .frame(width: width)
                                        .id(1)
                                        .rotationEffect(Angle(degrees: Double((scrollOffset)) ))
                                        
                                        Rectangle()
                                            .frame(width: width)
                                            .foregroundColor(Color.clear)
                                            .id(2)
                                    }
                                    .onAppear {
                                        sv.scrollTo(1)
                                    }
                                    .padding(padding)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
            }
            
        }
        .background(Color(hex: 0x3B3B3B))
        .edgesIgnoringSafeArea(.all)
    }
    
    func offset(_ proxy:GeometryProxy) -> some View {
        let minY = proxy.frame(in: .named("frameLayer")).minX
        self.scrollOffset = minY
        return Color.clear
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
