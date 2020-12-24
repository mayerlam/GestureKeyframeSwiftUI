//
//  Example1.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/20.
//

import SwiftUI

let timeLine: FAxis = [0, 60, 110, 136]
let keys: [CGFloat] = [0, 9.96, 3.29, 0]
let cs: [CGFloat] = [1, 1.1, 1.03, 1]
let co: [CGFloat] = [0, 0, 0, 1]
let sc: [CGFloat] = [1, 1, 1, 26.3]

struct Example1: View {
    @EnvironmentObject var scrollView: ViewDidScroll

    let containerRate: CGFloat = 1.7
    var body: some View {

        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let width: CGFloat = (size / 4.0) * containerRate
            let height = size / 2
            let padding = geo.size.width / 2.0 - width
            
            Keyframe(scrollView.offset, timeLine: timeLine) { f in
                ZStack(alignment: .center) {
                    
                    Circle()
                        .frame(width: 44, height: 44)
                        .foregroundColor(Color(hex: 0xD45E07).opacity(Double(f(co))))
                        .scaleEffect(f(sc))
                    
                    Example1CapsuleBg()
                        .frame(width: width * 2, height: height, alignment: .center)
                    Example1ScrollView(padding: padding)
                        .frame(width: geo.size.width, height: height)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .background(Color(hex: 0x3B3B3B))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Example1_Previews: PreviewProvider {
    static var previews: some View {
        let ob = ViewDidScroll()
        Example1()
            .environmentObject(ob)
    }
}
