//
//  Example1CapusleWithEmoji.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/23.
//

import SwiftUI

struct Example1CapusleWithEmoji: View {
    
    @EnvironmentObject var scrollView: ViewDidScroll
    
    var theme: KeyPath<Themes, Example1Theme> = \.light
    
    var widthKF: [CGFloat] = [12, 12] //[12, 6]
    
    var offsetKF: [CGFloat] = [0, 0] //[0, -3.96]
    
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
                Example1Emoji(theme: theme, widthKF: widthKF, offsetKF: offsetKF)
                    .frame(width: width / 4, height:  width / 4)
            }
        }
    }
}

struct Example1CapusleWithEmoji_Previews: PreviewProvider {
    static var previews: some View {
        
        Example1CapusleWithEmoji(theme: \.light)
            .previewLayout(.fixed(width: 300, height: 300))
            .background(Color(hex: 0x3B3B3B))
            
        Example1CapusleWithEmoji(theme: \.dark)
            .previewLayout(.fixed(width: 300, height: 300))
            .background(Color(hex: 0x3B3B3B))
    }
}
