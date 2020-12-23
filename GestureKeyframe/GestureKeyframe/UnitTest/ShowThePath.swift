//
//  ShowThePath.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/23.
//

import SwiftUI

struct ShowThePath: View {
    
    var curve: BasePath
    
    var path: Path = Path()
    @State private var celsius: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                
                ZStack {
                    PathView(path: curve.path!)
                    Circle().frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(.blue)
                        .offset(x: -curve.path!.boundingRect.width / 2, y: 10.0-curve.path!.boundingRect.height / 2)
                }.frame(width: geo.size.width, height: 300, alignment: .center)
                
                Slider(value: $celsius, in: 0...100, step: 0.1)
                    .frame(width: geo.size.width / 2)
                
                HStack {
                    Text("x percent:")
                    Spacer()
                    Text("\(curve.path!.boundingRect.width)")
                }
                .frame(width: geo.size.width / 2)
                
                HStack {
                    Text("ponitX     :")
                    Spacer()
                    Text("\(curve.path!.boundingRect.height)")
                }
                .frame(width: geo.size.width / 2)
                
                HStack {
                    Text("ponitY     :")
                    Spacer()
                    Text("\(curve.curValue(pect: CGFloat(celsius)) ?? 0)")
                }
                .frame(width: geo.size.width / 2)
                
                HStack {
                    Text("k              :")
                    Spacer()
                    Text("\(celsius)")
                }
                .frame(width: geo.size.width / 2)
            }
        }
    }
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

extension Path {
    func shape(in rect: CGSize) -> ScaledShape<Path> {
        let wScale = rect.width / self.boundingRect.width
        let hScale = rect.height / self.boundingRect.height
        return self.scale(x: wScale, y: hScale, anchor: .center)
    }
}

struct ShowShape: Shape {
    var path: Path
    func path(in rect: CGRect) -> Path {
        ShowShape.createPath(in: rect, path)
    }
    
    static func createPath(in rect: CGRect, _ path: Path) -> Path {
        let wScale = rect.width / path.boundingRect.width
        let hScale = rect.height / path.boundingRect.height
        return Path(path.scale(x: wScale, y: hScale, anchor: .center).shape.cgPath)
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
