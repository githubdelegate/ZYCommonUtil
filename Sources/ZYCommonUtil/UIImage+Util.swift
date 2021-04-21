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
    func resizedImage(size: CGSize) -> UIImage {
        if self.size.width < size.width {
            return self
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resizedImage(width: CGFloat) -> UIImage {
        let h = (self.size.height / self.size.width) * width
        return self.resizedImage(size: CGSize(width: width, height: h))
    }
    
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            return self.copy() as? UIImage
        }

        guard let cgImage = self.cgImage else {
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil //Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        @unknown default:
            print("")
        }
        //Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            print("")
        }
        ctx.concatenate(transform)
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
}

public extension UIImage {
     static func withColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
          let format = UIGraphicsImageRendererFormat()
          format.scale = 1
          let image =  UIGraphicsImageRenderer(size: size, format: format).image { rendererContext in
              color.setFill()
              rendererContext.fill(CGRect(origin: .zero, size: size))
          }
          return image
      }
}


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
