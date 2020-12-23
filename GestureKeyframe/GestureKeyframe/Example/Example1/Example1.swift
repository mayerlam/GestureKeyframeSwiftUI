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
    @State var xScale: CGFloat = .zero
    @State var xAngle: Angle = .zero
    
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
                        .foregroundColor(Color(hex: 0xD45E07).opacity(Double(f(co))))
                        .scaleEffect(f(sc))
                    
                    Example1CapsuleBg(offset: $scrollOffset)
                        .frame(width: width * 2, height: height, alignment: .center)

                    Example1ScrollView(scrollOffset: $scrollOffset, xScale: $xScale, xAngle: $xAngle, padding: padding)
                        .frame(width: geo.size.width, height: height)
                    
                    updateScale(f(cs))
                    updateAngle(f(keys))
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            
        }
        .background(Color(hex: 0x3B3B3B))
        .edgesIgnoringSafeArea(.all)
    }
    
    /// To update the Capsule scale
    /// - Parameter scale: given scale
    /// - Returns:
    private func updateScale(_ scale: CGFloat) -> some View {
        xScale = scale
        return Color.clear
    }
    
    /// To update the Capsule angle
    /// - Parameter angle: given angle
    /// - Returns:
    private func updateAngle(_ angle: CGFloat) -> some View {
        xAngle = Angle(degrees: Double(angle))
        return Color.clear
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
