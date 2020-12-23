//
//  Example3.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//

import SwiftUI

struct Example3: View {
    @State private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height) - 100
            let scale = size / 270
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .topLeading) {
                        BigBgImage()
                        StonePitView()
                            .offset(x: speedRate(x: dragOffset.width), y: speedRate(y: dragOffset.height))
                        BigFaceView(gesture: $dragOffset)
                    }
                    .frame(width: size, height: size, alignment: .center)
                    .clipShape(Circle())
                    Spacer()
                }
                Spacer()
            }
            .background(Color(hex: 0x151845))
            .gesture(
                DragGesture()
                    .onChanged({
                        if abs($0.translation.width + self.position.width) <= 105 * scale {
                            self.dragOffset.width = $0.translation.width + self.position.width
                        }
                        
                        if abs($0.translation.height + self.position.height) <= 93 * scale {
                            self.dragOffset.height = $0.translation.height + self.position.height
                        }
                    })
                    .onEnded({ (value) in
                        self.position = self.dragOffset
                    })
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func speedRate(x distance: CGFloat) -> CGFloat {
        return distance * 0.1
    }
    
    func speedRate(y distance: CGFloat) -> CGFloat {
        return distance * 0.1
    }
}

struct BigBgView_Previews: PreviewProvider {
    static var previews: some View {
        Example3()
    }
}
