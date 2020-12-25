//
//  FollowThePathView.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/24.
//

import SwiftUI

struct FollowThePathView: View {
    
    var curve: BasePath
    var x: CGFloat = .zero
    var y: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geo in
            let boundingRect = curve.path!.boundingRect
            let width = boundingRect.width
            let height = boundingRect.height
            let offsetX = boundingRect.minX
            let offsetY = boundingRect.minY
            let scaleX = geo.size.width / width
            let scaleY = geo.size.height / height
            
            ZStack(alignment: .center) {
                PathView(path: curve.path!)
                    .scaleEffect(x: scaleX, y: scaleY)
                Circle()
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(Color.blue)
                    .offset(x: -geo.size.width / 2, y: -geo.size.height / 2)
                    .offset(x: (x - offsetX) * scaleX, y: (y - offsetY) * scaleY)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct FollowThePathView_Previews: PreviewProvider {
    static var previews: some View {
        FollowThePathView(curve: BasePath(InfinityShape.createInfinityPath(in: CGRect(x: 0, y: 0, width: 200, height: 300))))
    }
}
