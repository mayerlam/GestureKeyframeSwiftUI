//
//  Example1Emoji.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/23.
//

import SwiftUI

struct Example1Emoji: View {
    
    @Binding var offset:CGFloat
    
    /// The emoji color theme
    var theme: KeyPath<Themes, Example1Theme> = \.light
    
    private var _theme: Example1Theme {
        Themes()[keyPath: theme]
    }
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let scale: CGFloat = size / 30.0
            Keyframe(offset, timeLine: [0, 136.0]) { value in
                ZStack {
                    Circle()
                        .frame(width: size, height: size)
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(_theme.emojiBackgroudColor)
                    
                    HStack(spacing: 0) {
                        eye()
                            .frame(width: 4 * scale, height: 4 * scale)
                        
                        Spacer()
                        
                        eye()
                            .frame(width: 4 * scale, height: 4 * scale)
                    }
                    .frame(width: 14 * scale)
                    .offset(y: -2 * scale)
                    .offset(x: value([0, -3.96]) * scale)
                    
                    HStack {
                        Spacer()
                        mouth()
                            .frame(width: value([12, 6]) * scale, height: 4 * scale, alignment: .leading)
                            .offset(y: 7 * scale)
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func eye() -> some View {
        Circle().foregroundColor(_theme.emojiFacialFeaturesColor)
    }
    
    private func mouth() -> some View {
        Capsule().foregroundColor(_theme.emojiFacialFeaturesColor)
    }
}

//
//struct Example1Emoji_Previews: PreviewProvider {
//    static var previews: some View {
//        Example1Emoji(theme: \.light)
//            .previewLayout(.fixed(width: 300, height: 300))
//
//        Example1Emoji(theme: \.dark)
//            .previewLayout(.fixed(width: 300, height: 300))
//            .background(Color(hex: 0x3B3B3B))
//    }
//}
