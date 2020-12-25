//
//  ShowThePath.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/23.
//

import SwiftUI

struct PathData {
    var xPect: CGFloat = .zero
    var x: CGFloat = .zero
    var y: CGFloat = .zero
    var k: CGFloat = .zero
    
    static let kps: [KeyPath<PathData, CGFloat>] = [
        \.xPect, \.x, \.y, \.k
    ]
}

struct ShowThePath: View {
    
    @Binding var celsius: CGFloat
    
    var curve: BasePath
    
    let getY: (CGFloat) -> CGFloat
    
    var body: some View {
        GeometryReader { geo in
            let pect = CGFloat(celsius / 100)
            let pathData = PathData(
                xPect: pect,
                x: curve.percent2X(pect)!,
                y: curve.curValue(pect: pect)!,
                k: tan(curve.curAngle(pect: pect)!)
            )
            
            VStack {
                HStack {
                    Spacer()
                    FollowThePathView(curve: curve, x: curve.percent2X(pect)!, y: getY(celsius))
                        .frame(width: geo.size.width - 60, height: (geo.size.width - 60) / 2)
                    Spacer()
                }.frame(width: geo.size.width, height: 250, alignment: .center)

                
                Slider(value: $celsius, in: 0...100, step: 0.01)
                    .frame(width: geo.size.width / 2)

                ForEach(0..<4) { i in
                    HStack {
                        HStack {
                            Text(titles[i])
                            Spacer()
                            Text("\(pathData[keyPath: PathData.kps[i]])")
                        }
                        .frame(width: geo.size.width / 2)
                    }
                }
            }
        }
    }
    
    private let titles = [
        "x percent:",
        "ponitX     :",
        "ponitY     :",
        "k              :"
    ]
}

struct ShowThePathPreview: View {
    
    @State var celsius: CGFloat = .zero
    
    let curve: BasePath
    
    var body: some View {
        ShowThePath(celsius: $celsius, curve: curve) {
            curve.curValue(pect: CGFloat($0 / 100))!
        }
    }
}

struct ShowThePath_Previews: PreviewProvider {
    static var previews: some View {
        ShowThePathPreview(curve: BasePath(InfinityShape.createInfinityPath(in: CGRect(x: 0, y: 0, width: 200, height: 300))))
    }
}


