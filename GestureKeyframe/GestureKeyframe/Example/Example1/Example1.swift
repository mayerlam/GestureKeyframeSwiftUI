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
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 0) {
                            CapsuleTemplate_ex1(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: Color.clear)
                                .frame(width: width, height: height, alignment: .center)
//                            HStack {
//                                Capsule()
//                                    .overlay(Capsule().stroke(Color(hex: 0xEFD319).opacity(0.12), lineWidth: 2))
//                                    .frame(width: height / capsuleRate, height: height)
//                                    .foregroundColor(Color.clear)
//                            }
//                            .frame(width: width, height: height, alignment: .center)
                            HStack {
                                Capsule()
                                    .overlay(Capsule().stroke(Color.white.opacity(0.06), lineWidth: 2))
                                    .frame(width: height / capsuleRate, height: height)
                                    .foregroundColor(Color.white.opacity(0.06))
                            }
                            .frame(width: width, height: height, alignment: .center)
                        }
                        .frame(width: width * 2, height: height, alignment: .center)
                        
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

                Spacer()
            }
        }
        .background(Color(hex: 0xD45E07))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CapsuleTemplate_ex1: View {
    
    var strokeColor: Color
    var strokerWidth: CGFloat
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height * 0.85)
            let height = width / 1.7
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center, spacing: 0) {
                    HStack {
                        Spacer()
                        Capsule()
                            .overlay(Capsule().stroke(strokeColor, lineWidth: strokerWidth))
                            .frame(width: height / 1.78, height: height, alignment: .center)
                            .foregroundColor(color)
                        Spacer()
                    }
                    .frame(width: width, height: height)
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct Example1_Previews: PreviewProvider {
    static var previews: some View {
        Example1()
        CapsuleTemplate_ex1(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: .blue)
            .previewLayout(.fixed(width: 300, height: 100))
        CapsuleTemplate_ex1(strokeColor: Color(hex: 0xEFD319).opacity(0.12), strokerWidth: 2, color: .blue)
            .previewLayout(.fixed(width: 159.7, height: 187.3))
    }
}
