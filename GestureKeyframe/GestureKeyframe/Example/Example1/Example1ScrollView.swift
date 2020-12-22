//
//  Example1ScrollView.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/22.
//

import SwiftUI

struct Example1ScrollView: View {
    
    @Binding var scrollOffset: CGFloat
    @State var xScale: CGFloat = .zero
    @State var xAngle: Angle = .zero
    var padding: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width / 2
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
                        .rotationEffect(xAngle)
                        .scaleEffect(xScale)
                        
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

struct Example1ScrollViewPre: View {
    @State var s: CGFloat = .zero
    var body: some View {
        Example1ScrollView(scrollOffset: $s, xScale: 1.0, xAngle: Angle(degrees: 0), padding: 20)
    }
}

struct Example1ScrollView_Previews: PreviewProvider {
    
    static var previews: some View {
        Example1ScrollViewPre()
    }
}
