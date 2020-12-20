//
//  Example1.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/20.
//

import SwiftUI

struct Example1: View {
    let capsuleRate: CGFloat = 1.78
    let containerRate: CGFloat = 1.7
    
    let width: CGFloat = 50.0
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let width: CGFloat = (size / 4.0) * containerRate
            let height = size / 2
    
            VStack {
                Spacer()
                ZStack {
                    HStack(alignment: .center, spacing: 0) {
                        Spacer()
                        HStack {
                            Capsule()
                                .overlay(Capsule().stroke(Color(hex: 0xEFD319).opacity(0.12), lineWidth: 2))
                                .frame(width: height / capsuleRate, height: height)
                                .foregroundColor(Color.clear)
                        }
                        .frame(width: width, height: height, alignment: .center)
                        HStack {
                            Capsule()
                                .overlay(Capsule().stroke(Color.white.opacity(0.06), lineWidth: 2))
                                .frame(width: height / capsuleRate, height: height)
                                .foregroundColor(Color.white.opacity(0.06))
                        }
                        .frame(width: width, height: height, alignment: .center)
                        Spacer()
                    }
                    .frame(width: size, height: height)
                    
                    HStack {
                        Capsule()
                            .overlay(Capsule().stroke(Color(hex: 0xEFD319).opacity(0.12), lineWidth: 2))
                            .frame(width: height / capsuleRate, height: height)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: width, height: height, alignment: .center)
                }
                Spacer()
            }
        }
        .background(Color(hex: 0xD45E07))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Example1_Previews: PreviewProvider {
    static var previews: some View {
        Example1()
    }
}
