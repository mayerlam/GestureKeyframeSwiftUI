//
//  Example1CapsuleBg.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/22.
//

import SwiftUI

struct Example1CapsuleBg: View {
    
    @State var bind: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            HStack(alignment: .center, spacing: 0) {
                // 左侧静态图形
                Example1CapsuleTemplate(
                    strokeColor : Color(hex: 0xEFD319).opacity(0.12),
                    strokerWidth: 2,
                    color       : Color.clear
                )
                .frame(width: width / 2, alignment: .center)
                
                // 右侧静态图形
                Example1CapsuleTemplate(
                    strokeColor : Color.white.opacity(0.06),
                    strokerWidth: 2,
                    color       : Color.white.opacity(0.06)
                )
                .frame(width: width / 2, alignment: .center)
            }
            .frame(width: width, height: height, alignment: .center)
        }
    }
}

struct ExampleCapsuleBg_Previews: PreviewProvider {
    static var previews: some View {
        Example1CapsuleBg()
    }
}

struct Example1CapsuleTemplate: View {
    
    var strokeColor: Color
    var strokerWidth: CGFloat
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height * 0.85)
            let height = width / 0.85
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Capsule()
                    .overlay(
                        Capsule().stroke(strokeColor, lineWidth: strokerWidth)
                    )
                    .frame(
                        width: height / 1.78,
                        height: height,
                        alignment: .center
                    )
                    .foregroundColor(color)
                
                Spacer()
            }
            .frame(
                width : geometry.size.width,
                height: geometry.size.height
            )
            .aspectRatio(contentMode: .fill)
        }
    }
}
