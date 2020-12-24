//
//  Navigator.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/20.
//

import SwiftUI

struct Navigator: View {
    var body: some View {
        let ob = ViewDidScroll()
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: Example1().environmentObject(ob), label: {
                        Text("Example1")
                    })
                    NavigationLink(destination: Example2(), label: {
                        Text("Example2")
                    })
                    NavigationLink(destination: Example3(), label: {
                        Text("Example3")
                    })
                }
            }
        }
    }
}

struct Navigator_Previews: PreviewProvider {
    static var previews: some View {
        Navigator()
    }
}
