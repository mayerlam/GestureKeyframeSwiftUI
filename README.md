# GestureKeyframeSwiftUI

> 通过设定一系列的关键帧，生成一个可控的动画

此工具基于SwiftUI。
可以帮助开发者从原型设计中转移到代码之中。通过对某个对象设定关键帧，再绑定一个可控或不可控的变量，使对象根据该变量生成动画

## 目录
- 使用指南
- [环境需求](#Reference)
- [安装](#Installation)
  - [CocoaPods](#CocoaPods)
  - [手动](#Manual)
- [使用方法](#Usage)
  - [原理](#Principle)
- [使用许可](#License)

## Getting Started

### Reference

尽可能地保持MacOS和Xcode的最新更新。这个工具至少需要保证以下环境：

```
swift  : 4.0+
iOS    : 13.0+
macOS  : 10.15+
watchOS: 6.0+
tvOS   : 13.0+
```

### Installation

### CocoaPods
> 如果你之前没有使用过CocoaPods，我建议你可以点击[CocoaPods](https://cocoapods.org)开始新的学习。

在你的Podfile文件中加入下面这一行：
```
pod 'GestureKeyframeSwiftUI'
```
然后，执行：
```sh
pod install
```

如果提示找不到该组件，请确保更新CocoaPods，以及库源的最新版本。如果你的CocoaPods设置了国内源，这可能会造成源库不同步的问题。

或者尝试在Podfile第一行加上：
```
source 'https://cdn.cocoapods.org/'
```
### Manual

下载最新的 [Release](https://github.com/mayerlam/GestureKeyframeSwiftUI/releases)，解压然后把文件夹`source`复制到你的项目中即可

### Usage

这个工具拥有一个结构体`Keyframe`，它的定义方法类似于SwiftUI中`GeometryReader`，它带有一个带尾闭包，可以向闭包内传递参数，同时可以将闭包内的视图暴露到外部。

我们可以非常快速地通过下面的代码，来使用这个工具：

```
struct Example: View {

  /** 
   * 你可以把它绑定到你的手势产出的变量，或者任何你可以控制的参数，
   * 甚至乎，你可以把它绑定到时间，这样它就会等同于播放动画
   *
   */
  @State var x: CGFloat = .zero
  
  /**  
   *  一个独立的关键帧是同时包含x坐标以及对应的帧值
   *  这似乎用一个CGPoint去声明一个关键帧更好
   *  但是这个工具采用的是横纵分离，这在后面的例子中，你就能看到为什么要这样做。
   *  这个集合包含的是所有关键帧对应的x坐标。
   *
   */
  let timeLine: Set<CGFloat> = [0, 60, 110, 136]

  /** 
   *  这个数组包含的是关键帧对应状态量，我们将会把它作用于视图的偏移上
   *
   */
  let offsetKeyframes: [CGFloat] = [100, 150, 100, 200]

  /**
   *  这个数组包含的是关键帧对应状态量，我们将会把它作用于视图的缩放上
   *
   */
  let scaleKeyframes: [CGFloat] = [1, 1.5, 1.3, 2]

  var body: some View {

    Keyframe(bindIntercept: x, timeLine: timeLine) { value in

      Circle()
        .frame(width: 44, height: 44)
        .foregroundColor(Color.red)

        /**
         *  value(_ :[CGFloat]) 这个函数实际上是闭包传入的
         *  它已经在一开始包含了timeLine和x的信息
         *  然后再根据给定offsetKeyframes和当前的x计算出当前的值
         *  SwitUI应该会自动刷新视图
         *
         */
        .offset(x: value(offsetKeyframes))

        /**
         * 我们还可以通过传入不同的状态量，来改变不同视图不同属性在同一个时间轴上的变化
         * 这也就解释了上面提到的，为什么我们需要横纵分离
         *
         */
        .scaleEffect(value(scaleKeyframes))
    }
  }
}

```

### Principle

`Keyframe`的工作依赖着一个变化曲线，它是`Path`的一个实例。然后通过监控绑定的变量`x`（基于上面的例子），计算这个`x`在path上的坐标，从而获得纵坐标。

在上面的例子中，它通过组合给定的`timeLine`和`offsetKeyframes`（或`scaleKeyframes`），生成一个点集。基于这个点集就可以生成一个`Path`，由于我们没有设定曲线的类型，所以`Path`的默认构造方法是线性的，或者说是折线的。目前这个工具只供折线（一阶）和三阶贝塞尔曲线的构造。

当然，这个工具直接暴露了一个使用`Path`的构造接口给开发者：

```
  Keyframe (
    _ bindIntercept     : CGFloat,  // 绑定的变量
    path                : Path,  // 给定一个Path曲线
    precision           : CGFloat = 0.001,  // 计算精度
    @ViewBuilder content: ( @escaping () -> CGFloat) -> Content
  ) 
```

## License

[MIT](LICENSE) © Mayer Lam

