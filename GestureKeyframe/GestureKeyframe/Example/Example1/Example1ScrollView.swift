//
//  Example1ScrollView.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/22.
//

import SwiftUI

struct Example1ScrollView: View {
    
    @Binding var scrollOffset: CGFloat
    @Binding var xScale: CGFloat
    @Binding var xAngle: Angle
    var padding: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width / 2 -  padding
            ScrollViewReader { sv in
                ScrollViewOffset(.horizontal, showsIndicators: false) {
                    scrollOffset = -$0
                } content: {
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(Color.clear)
                        
                        // 顶层动态图形
                        Example1CapusleWithEmoji(offset: $scrollOffset, theme: \.light)
                        .frame(width: width, height: geo.size.height)
                        .rotationEffect(xAngle)
                        .scaleEffect(xScale)
                        
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(Color.clear)
                    }
                    .padding(.all, padding)
                }
            }
            
        }.offset(y: -padding)
    }
}

struct Example1ScrollViewPre: View {
    @State var s: CGFloat = .zero
    @State var xScale: CGFloat = .zero
    @State var xAngle: Angle = .zero
    
    var body: some View {
        Example1ScrollView(scrollOffset: $s, xScale: $xScale, xAngle: $xAngle, padding: 20)
    }
}

struct Example1ScrollView_Previews: PreviewProvider {
    
    static var previews: some View {
        Example1ScrollViewPre()
            .colorScheme(.dark)
    }
}
