//
//  UIImage+Util.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    /// 根据文字生成包含第一个文字的图片
    /// - Parameters:
    ///   - text: 文字
    ///   - size: 大小
    ///   - backColor: 颜色
    ///   - textColor: yans
    ///   - isCircle: 是不是要圆形
    /// - Returns: description
    class func image(_ text: String, size: (CGFloat, CGFloat), backColor: UIColor = UIColor(hexString: "#07CB84"), textColor: UIColor = UIColor.white, isCircle: Bool = true) -> UIImage? {
        // 过滤空""
        if text.isEmpty { return nil }
        // 取第一个字符(测试了,太长了的话,效果并不好)
        let letter = (text as NSString).substring(to: 1)
        let sise = CGSize(width: size.0, height: size.1)
        let rect = CGRect(origin: CGPoint.zero, size: sise)
        // 开启上下文
        UIGraphicsBeginImageContext(sise)
        // 拿到上下文
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        // 取较小的边
        let minSide = min(size.0, size.1)
        // 是否圆角裁剪
        if isCircle {
            UIBezierPath(roundedRect: rect, cornerRadius: minSide * 0.5).addClip()
        }
        // 设置填充颜色
        ctx.setFillColor(backColor.cgColor)
        // 填充绘制
        ctx.fill(rect)
        let attr = [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: minSide * 0.5)]

        let attStr = NSAttributedString(string: letter, attributes: attr)
        let getSize = attStr.getSize()
        var xR = ((minSide - getSize.width) / minSide) / 2
        var yR = ((minSide - getSize.height) / minSide) / 2
        if xR < 0 || xR > 0.5 {
            xR = 0.25
        }

        if yR < 0 || yR > 0.5 {
            yR = 0.25
        }

        // 写入文字
        (letter as NSString).draw(at: CGPoint(x: minSide * xR, y: minSide * yR), withAttributes: attr)
        // 得到图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return image
    }
}
