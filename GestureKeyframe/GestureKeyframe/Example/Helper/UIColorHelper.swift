//
//  UIColorHelper.swift
//  GestureKeyframe
//
//  Created by Mayer Lam on 2020/12/19.
//

import UIKit
import SwiftUI

public extension Color {
    init(hex string: String, alpha: CGFloat = 1.0) {
        self.init(UIColor(hex: string, alpha: alpha))
    }
    
    init(hex number: Int, alpha: CGFloat = 1.0) {
        self.init(UIColor(hex: number, alpha: alpha))
    }
}

public extension UIColor {
    
    /// 便利构造Hex颜色
    ///
    /// - Parameters:
    ///   - string: hex值
    ///   - alpha: alpha值，默认1.0
    convenience init(hex string: String, alpha: CGFloat = 1.0) {
        
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6  else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        if hex.count == 3 {
            for (indec, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: indec * 2))
            }
        }
        
        self.init(
            red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hex number: Int, alpha: CGFloat = 1.0) {
        
        
        guard number <= 0xFFFFFF  else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        
        self.init(
            red: CGFloat((number >> 16) & 0xFF) / 255.0,
            green: CGFloat((number >> 8) & 0xFF) / 255.0,
            blue: CGFloat(number & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}

