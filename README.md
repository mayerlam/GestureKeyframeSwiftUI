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
- [使用许可](#License)

## Getting Started

### Reference

尽可能地保持MacOS和Xcode的最新更新。这个工具至少需要保证以下环境：

```
swift 4.0 +
iOS: 13.0+
OSX: 10.15+
watchos: 6.0+
tvos: 13.0+
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

下载最新的 [Release](https://github.com/mayerlam/GestureKeyframeSwiftUI/releases)

解压然后把文件夹`source`复制到你的项目中即可

### Usage

```
```

## License

这个项目 MIT 协议， 请点击 [LICENSE.md](LICENSE.md) 了解更多细节。
