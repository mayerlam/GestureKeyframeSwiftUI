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
                k: curve.curAngle(pect: pect)!
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
                
                Slider(value: $celsius, in: 0...100, step: 0.1)
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
    
    let titles = [
        "x percent:",
        "ponitX     :",
        "ponitY     :",
        "k              :"
    ]
}

struct PathView: View {
    var path: Path
    
    var body: some View {
        VStack {
            path
                .stroke(Color.purple, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .miter, miterLimit: 0))
        }
        .frame(width: path.boundingRect.width, height: path.boundingRect.height, alignment: .center)
        .offset(x: -path.boundingRect.minX, y: -path.boundingRect.minY)
    }
}

struct ShowThePath_Previews: PreviewProvider {
    static var previews: some View {
        ShowThePath(curve:  BasePath(InfinityShape.createInfinityPath(in: CGRect(x: 0, y: 0, width: 200, height: 300))) )
    }
}

struct InfinityShape: Shape {
    func path(in rect: CGRect) -> Path {
        return InfinityShape.createInfinityPath(in: rect)
    }

    static func createInfinityPath(in rect: CGRect) -> Path {
        let height = rect.size.height
        let width = rect.size.width
        let heightFactor = height/4
        let widthFactor = width/4

        var path = Path()

        path.move(to: CGPoint(x:widthFactor, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor), control1: CGPoint(x:0, y: heightFactor * 3), control2: CGPoint(x:0, y: heightFactor))

        path.move(to: CGPoint(x:widthFactor, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3), control1: CGPoint(x:widthFactor * 2, y: heightFactor), control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))

        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor), control1: CGPoint(x:widthFactor * 4 + 5, y: heightFactor * 3), control2: CGPoint(x:widthFactor * 4 + 5, y: heightFactor))

        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor * 3), control1: CGPoint(x:widthFactor * 2, y: heightFactor), control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))

        return path
    }
}
