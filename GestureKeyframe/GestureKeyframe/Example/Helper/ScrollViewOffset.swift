//
//  ScrollViewOffset.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/22.
//

import SwiftUI

private struct OffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ScrollViewOffset<Content: View>: View {

    /// The scrollable axes of the scroll view.
    ///
    /// The default value is ``Axis/vertical``.
    public var axes: Axis.Set

    /// A value that indicates whether the scroll view displays the scrollable
    /// component of the content offset, in a way that's suitable for the
    /// platform.
    ///
    /// The default is `true`.
    public var showsIndicators: Bool

    let onOffsetChange: (CGFloat) -> Void
    let content: () -> Content

    init( _ axes: Axis.Set = .vertical, showsIndicators: Bool = true,
    onOffsetChange: @escaping (CGFloat) -> Void,
    @ViewBuilder content: @escaping () -> Content
    ) {
        self.onOffsetChange = onOffsetChange
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content
    }

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
          offsetReader
          content()
            .padding(.top, -8)
        }
        .coordinateSpace(name: "frameLayer")
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
    }

    var offsetReader: some View {
        GeometryReader { proxy in
            
            let value: CGFloat = {
                switch axes {
                case .horizontal:
                    return proxy.frame(in: .named("frameLayer")).minX
                default:
                    return proxy.frame(in: .named("frameLayer")).minY
                }
            } ()
            
            Color.clear
                .preference(
                    key: OffsetPreferenceKey.self,
                    value: value
                )
        }
        .frame(height: 0)
    }
}
