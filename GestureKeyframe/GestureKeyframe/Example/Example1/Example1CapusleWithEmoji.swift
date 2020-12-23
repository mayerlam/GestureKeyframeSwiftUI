//
//  Example1CapusleWithEmoji.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/23.
//

import SwiftUI

struct Example1CapusleWithEmoji: View {
    
    @Binding var offset: CGFloat
    
    var theme: KeyPath<Themes, Example1Theme> = \.light
    
    private var _theme: Example1Theme {
        Themes()[keyPath: theme]
    }
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            
            ZStack {
                Example1CapsuleTemplate(
                    strokeColor : _theme.capsuleStokeColor,
                    strokerWidth: 2,
                    color       : _theme.capsuleBackgroudColor
                )
                .frame(width: width, alignment: .center)
                Example1Emoji(offset: $offset, theme: theme)
                    .frame(width: width / 4, height:  width / 4)
            }
        }
    }
}
//
//struct Example1CapusleWithEmoji_Previews: PreviewProvider {
//    static var previews: some View {
//        Example1CapusleWithEmoji(theme: \.light)
//            .previewLayout(.fixed(width: 300, height: 300))
//            .background(Color(hex: 0x3B3B3B))
//
//        Example1CapusleWithEmoji(theme: \.dark)
//            .previewLayout(.fixed(width: 300, height: 300))
//            .background(Color(hex: 0x3B3B3B))
//    }
//}
//
//Example1CapsuleTemplate(
//    strokeColor : Color.white.opacity(0.06),
//    strokerWidth: 2,
//    color       : Color.white.opacity(0.06)
//)
//.frame(width: width / 2, alignment: .center)
