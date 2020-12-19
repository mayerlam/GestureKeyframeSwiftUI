//
//  Keyframe.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/19.
//

import SwiftUI
public enum UseCoordinate {
    case x
    case y
}

/// 变化曲线类型
public enum CurveType {
    case line
    case curve
    case curvedSurface
    case oneDimensional
    case twoDimensional
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct AutoGesture<Content> : View where Content : View {
    
    public var body: Content
    
    public init (_ bindIntercept: CGFloat, timeLine: [CGFloat], curveType: CurveType = .line, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping ([CGFloat]) -> CGFloat) -> Content) {
        
        func gen(_ keyFrames: [CGFloat]) -> CGFloat {
            return AutoGesture.oneDimensionalHandler(keyFrames, bindIntercept, timeLine: timeLine, curveType: curveType, precision: precision)
        }

        self.body = content(gen)
    }
    
    /// 此构造方法可以方便地监控指针在整个平面的移动
    /// - Parameters:
    ///   - bindIntercept: 绑定这个参数用来映射值
    ///   - timeLine: 给定一个时间线
    ///   - curveType: 构造的曲线类型
    ///   - precision: 计算精度
    ///   - content: 用以代理渲染视图
    public init (_ bindIntercept: CGPoint, timeLine: [CGPoint], curveType: CurveType = .line, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping ([CGFloat], UseCoordinate) -> CGFloat) -> Content) {

        func gen(_ keyFrames: [CGFloat], _ use: UseCoordinate) -> CGFloat {
            if use == .x {
                let tl: [CGFloat] = timeLine.map { $0.x }
                return AutoGesture.oneDimensionalHandler(keyFrames, bindIntercept.x, timeLine: tl, curveType: curveType, precision: precision)
            } else  {
                let tl: [CGFloat] = timeLine.map { $0.y }
                return AutoGesture.oneDimensionalHandler(keyFrames, bindIntercept.y, timeLine: tl, curveType: curveType, precision: precision)
            }
        }
        
        self.body = content(gen)
    }
    
    /// `oneDimensionalHandler`生成函数
    /// 是一个通过变化曲线`path`，以及给定指针x坐标而映射得到对应的值
    /// 可以应用在只提供若干关键帧，而推算出所有的变化
    ///
    /// 在AutoGesture初始化时，绑定了`bindIntercept`
    /// 以及设定了数组`timeLine`
    /// 将`timeLine`作为x坐标, `keyFrames` 作为y坐标，构建一个点集
    /// 通过这个点集生成一个变化曲线`path`
    /// 最后，由于`bindIntercept`的变化映射成`x`坐标，再通过`path`
    /// 映射得到对应的`value`值，下面是应用在SwiftUI中的例子:
    ///
    ///     @State var gestureOffset: CGSize
    ///
    ///     var body: some View {
    ///         AutoGesture(gestureOffset, timeLine: [x1, x2, x3], curveType: .line) { value in
    ///             Text("\(value([[y1, y2, y3]]))")
    ///         }
    ///     }
    ///
    /// 上面的代码，实际上会构建三个点`(x1, y1)`，`(x2, y2)`，`(x3, y3)`
    /// 然后再通过指定的方式连接这三个点，得到一个曲线
    /// 再根据监控`gestureOffset`的变化，映射到这个曲线上`x`变化，从而得到`y`
    ///
    /// 横、纵坐标分离是因为在大多数的业务场景中，有多个属性会在同一个节点产生变化
    /// 因而，上面的代码，可以灵活地进行编写，如下：
    ///
    ///     @State var gestureOffset: CGSize
    ///
    ///     var body: some View {
    ///         AutoGesture(gestureOffset, timeLine: [x1, x2, x3], curveType: .line) {
    ///             Text("\($0([y1, y2, y3]))")
    ///
    ///             Cicle()
    ///                 .frame(width: $0([y4, y5, y6]), heigth: $0([y7, y8, y9]))
    ///         }
    ///     }
    ///
    /// - Parameter keyFrames: 关键帧的值
    /// - Returns: 当前的帧值
    public static func oneDimensionalHandler(_ keyFrames: [CGFloat], _ bindIntercept: CGFloat, timeLine: [CGFloat], curveType: CurveType = .line, precision: CGFloat = 0.001) -> CGFloat {
        
        /// 对时间线进行排序
        let timeLine_s = timeLine.sorted(by: <)
        let ml = min(timeLine_s.count, keyFrames.count)
        let tl = timeLine_s[0..<ml]
        let kf = keyFrames[0..<ml]
        
        var nodes: [CGPoint] = []
        
        for (index, element) in tl.enumerated() {
            nodes.append(CGPoint(x: element, y: kf[index]))
        }

        switch curveType {
            case .line:
                let timeLineCurv = PolylineCurve(nodes)
                return timeLineCurv.getValue(x: bindIntercept, precision: precision)
            default:
                return .zero
        }
    }
}
