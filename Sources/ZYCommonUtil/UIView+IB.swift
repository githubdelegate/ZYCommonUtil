//
//  UIViewUtil.swift
//  cleaner
//
//  Created by zy on 2020/8/26.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    private struct AssociatedKey {
        static var animationUserInteractKey = "animationUserInteractKey"
    }
    
    /// 是否支持动画过程中支持点击事件 ， 记住 要设置animation option userinteract
    var animationUserInteract: Bool {
        set {
            setAssociated(value: newValue, associatedKey: &AssociatedKey.animationUserInteractKey)
        }
        
        get {
            return getAssociated(associatedKey: &AssociatedKey.animationUserInteractKey)  ?? true
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if animationUserInteract {
            let p = self.convert(point, to: superview)
            if let pre = layer.presentation() {
                return (pre.hitTest(p) != nil)
            }
        }
        return super.point(inside: point, with: event)
    }
}


// 方便 在 xib 里面直接 设置各种属性
public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if layer.shadowColor != nil {
                return UIColor(cgColor: layer.shadowColor!)
            } else {
                return nil
            }
        }
        set {
            if newValue != nil {
                layer.shadowColor = newValue?.cgColor
                layer.masksToBounds = false
            }
        }
      }
      
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
      }
      
    @IBInspectable var shadowOffset: CGSize {
        get
        {
            return layer.shadowOffset
        }
        
        set
        {
            layer.shadowOffset = newValue
        }
      }
      
    @IBInspectable var shadowRadius: CGFloat {
        get
        {
            return layer.shadowRadius
        }
    
        set
        {
            layer.shadowRadius = newValue
        }
      }
    
    @IBInspectable var rotation: CGFloat {
        get
        {
            return 1.0
        }
        set
        {
            transform = CGAffineTransform(rotationAngle: newValue)
        }
      }

}

// 自定义view，用@IBDesignable修饰
@IBDesignable open class GrammView: UIView {
}
@IBDesignable open class GrammBtn: UIButton {
}
@IBDesignable open class GrammLabel: UILabel {
}
@IBDesignable open class GrammImageView: UIImageView {
}


/// 顶部对其label
public class VerticalTopAlignLabel: UILabel {
    public override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }

        let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font!])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height

        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }

        super.drawText(in: newRect)
    }

}
