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
    
    var curve: BasePath
    
    @State private var celsius: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            let pect = CGFloat(celsius / 100)
            let boundingRect = curve.path!.boundingRect
            let width = boundingRect.width / 2
            let height = boundingRect.height / 2
            let offsetX = boundingRect.minX
            let offsetY = boundingRect.minY
            let pathData = PathData(
                xPect: pect,
                x: curve.percent2X(pect)!,
                y: curve.curValue(pect: pect)!,
                k: tan(curve.curAngle(pect: pect)!)
            )
            
            VStack {
                ZStack(alignment: .center) {
                    PathView(path: curve.path!)
                    Circle()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(Color.blue)
                        .offset(x: -width, y: -height)
                        .offset(x: curve.percent2X(pect)! - offsetX,
                                y: curve.curValue(pect: pect)! - offsetY)
                }
                .frame(width: geo.size.width, height: 300, alignment: .center)
                
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

struct ShowThePath_Previews: PreviewProvider {
    static var previews: some View {
        ShowThePath(curve:  BasePath(InfinityShape.createInfinityPath(in: CGRect(x: 0, y: 0, width: 200, height: 300))) )
    }
}


