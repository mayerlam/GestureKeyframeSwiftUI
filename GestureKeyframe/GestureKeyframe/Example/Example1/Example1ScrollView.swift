//
//  Example1ScrollView.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/22.
//

import SwiftUI

struct Example1ScrollView: View {
    
    @EnvironmentObject var scrollView: ViewDidScroll
        
    var padding: CGFloat = .zero
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width / 2 -  padding
            
            Keyframe(scrollView.offset, timeLine: timeLine) { value in
                ScrollViewReader { sv in
                    ScrollViewOffset(.horizontal, showsIndicators: false) {
                        scrollView.offset = -$0
                    } content: {
                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: width)
                                .foregroundColor(Color.clear)
                            
                            // 顶层动态图形
                            Example1CapusleWithEmoji(theme: \.light)
                            .frame(width: width, height: geo.size.height)
                            .rotationEffect(Angle(degrees: Double(value(keys))))
                            .scaleEffect(value(cs))
                            
                            Rectangle()
                                .frame(width: width)
                                .foregroundColor(Color.clear)
                        }
                        .padding(.all, padding)
                    }
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
        Example1ScrollView(padding: 20)
    }
}

struct Example1ScrollView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ob = ViewDidScroll()

        Example1ScrollViewPre()
            .background(Color.black)
            .environmentObject(ob)
    }
}

class ViewDidScroll: ObservableObject {
    @Published var offset: CGFloat = .zero
}
