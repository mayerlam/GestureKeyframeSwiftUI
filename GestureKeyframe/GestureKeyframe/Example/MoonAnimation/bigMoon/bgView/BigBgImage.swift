//
//  BigBgImage.swift
//  Moon-Animation
//
//  Created by Mayer Lam on 2020/12/13.
//

import SwiftUI

struct BigBgImage: View {
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            Image("bgBig").resizable()
                .frame(width: size , height: size, alignment: .topLeading)
                .clipShape(Circle())
        }
    }
}

struct BigBgImage_Previews: PreviewProvider {
    static var previews: some View {
        BigBgImage()
            .previewLayout(.fixed(width: 100, height: 100))
        
    }
}
