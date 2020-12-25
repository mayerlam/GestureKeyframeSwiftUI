//
//  Keyframe.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/19.
//

import SwiftUI

public typealias FAxis = Set<CGFloat>
public typealias PTAxis = Set<KFPoint>

public enum UseCoordinate {
    case x
    case y
}

/// 变化曲线类型
public enum CurveType {
    case line
    case Cubic
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Keyframe<Content> : View where Content : View {
    
    public var body: Content
    
    public init (bindPect: CGFloat, timeLine: FAxis, curveType: CurveType = .line, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping ([CGFloat]) -> CGFloat) -> Content) {
        func gen(_ keyFrames: [CGFloat]) -> CGFloat {
            return Keyframe.oneDimensionalHandler(pect: bindPect, keyFrames, timeLine, curveType, precision)
        }
        self.body = content(gen)
    }
    
    /// `oneDimensionalHandler`生成函数
    /// 是一个通过变化曲线`path`，以及给定指针x坐标而映射得到对应的值
    /// 可以应用在只提供若干关键帧，而推算出所有的变化
    ///
    /// 在AutoGesture初始化时，绑定了`bindPect`
    /// 以及设定了数组`timeLine`
    /// 将`timeLine`作为x坐标, `keyFrames` 作为y坐标，构建一个点集
    /// 通过这个点集生成一个变化曲线`path`
    /// 最后，由于`bindPect`的变化映射成`x`坐标(百分比)，再通过`path`
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
    /// - Parameters:
    ///   - keyFrames: 关键帧的值
    ///   - bindPect: 将被监控的变化量
    ///   - timeLine: 关键帧时间线
    ///   - curveType: path类型
    ///   - precision: 精度
    /// - Returns: 当前的帧值
    public static func oneDimensionalHandler(pect: CGFloat, _ keyFrames: [CGFloat], _ timeLine: FAxis, _ curveType: CurveType, _ precision: CGFloat = 0.001) -> CGFloat {
        
        /// 对时间线进行排序
        let timeLineAsc = timeLine.sorted(by: <)
        let ml = min(timeLineAsc.count, keyFrames.count)
        let tl = timeLineAsc[0..<ml]
        let kf = keyFrames[0..<ml]
        
        var nodes: [CGPoint] = []
        
        for (index, element) in tl.enumerated() {
            nodes.append(CGPoint(x: element, y: kf[index]))
        }
        
        switch curveType {
        case .line:
            let timeLineCurv = PolylineCurve(nodes)
            /**
             * We use the `basePath.curValue(x: CGFloat, precision: CGFloat)` method
             * Because we think the keyframe-path suppose an single-value function
             */
            return timeLineCurv.curValue(pect: pect, precision: precision)!
        case .Cubic:
            let curve = CubicCurve(nodes)
            return curve.curValue(pect: pect, precision: precision)!
        }
    }
}

extension Keyframe {
    
    public init (_ bindIntercept: CGFloat, timeLine: FAxis, curveType: CurveType = .line, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping ([CGFloat]) -> CGFloat) -> Content) {
        
        func gen(_ keyFrames: [CGFloat]) -> CGFloat {
            return Keyframe.oneDimensionalHandler(intercept: bindIntercept, keyFrames, timeLine, curveType, precision)
        }
        
        self.body = content(gen)
    }
    
    public static func oneDimensionalHandler(intercept: CGFloat, _ keyFrames: [CGFloat], _ timeLine: FAxis, _ curveType: CurveType, _ precision: CGFloat = 0.001) -> CGFloat {
        guard timeLine.count > 1 else {
            return .nan
        }
        /// 对时间线进行排序
        let timeLineAsc = timeLine.sorted(by: <)
        let pect:CGFloat = (intercept - timeLineAsc.first!) / ( timeLineAsc.last! - timeLineAsc.first!)
        return Keyframe.oneDimensionalHandler(pect: pect, keyFrames, timeLine, curveType, precision)
    }
}

extension Keyframe {
    /// 此构造方法可以方便地监控指针在整个平面的移动
    /// - Parameters:
    ///   - bindIntercept: 绑定这个参数用来映射值
    ///   - timeLine: 给定一个时间线
    ///   - curveType: 构造的曲线类型
    ///   - precision: 计算精度
    ///   - content: 用以代理渲染视图
    public init (_ bindIntercept: CGPoint, timeLine: PTAxis, curveType: CurveType = .line, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping ([CGFloat], UseCoordinate) -> CGFloat) -> Content) {
        
        func gen(_ keyFrames: [CGFloat], _ use: UseCoordinate) -> CGFloat {
            if use == .x {
                let tl: FAxis = Set(timeLine.map { $0.x })
                return Keyframe.oneDimensionalHandler(intercept: bindIntercept.x, keyFrames, tl, curveType, precision)
            } else  {
                let tl: FAxis = Set(timeLine.map { $0.y })
                return Keyframe.oneDimensionalHandler(intercept: bindIntercept.y, keyFrames, tl, curveType, precision)
            }
        }
        
        self.body = content(gen)
    }
}

extension Keyframe {
    public init (_ bindIntercept: CGSize, timeLine: PTAxis, curveType: CurveType = .line, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping ([CGFloat], UseCoordinate) -> CGFloat) -> Content) {
        let point = CGPoint(x: bindIntercept.width, y: bindIntercept.height)
        self.init(point, timeLine: timeLine, content: content)
    }
}


//extension Keyframe {
//    public init (_ bindIntercept: CGFloat, path: Path, precision: CGFloat = 0.001, @ViewBuilder content: ( @escaping () -> CGFloat) -> Content) {
//        func gen() -> CGFloat {
//
//        }
//    }
//}
