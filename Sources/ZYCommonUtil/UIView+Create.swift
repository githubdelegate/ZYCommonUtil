//
//  File.swift
//  
//
//  Created by edz on 2021/4/21.
//

import Foundation
import UIKit

public extension UIView {
    @discardableResult
    func addTo(v: UIView) -> Self {
        v.addSubview(self)
        return self
    }
    
    @discardableResult
    func bgColor(c: UIColor) -> Self {
        backgroundColor = c
        return self
    }
    
    @discardableResult
    func shadowCor(c: UIColor, offx: CGFloat = 0, offy: CGFloat = 2,radius: CGFloat = 10, opc: CGFloat = 1) -> Self {
        layer.shadowColor = c.cgColor
        layer.shadowOffset = CGSize(width: offx, height: offy)
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opc)
        return self
    }
}

public extension UILabel {
    @discardableResult
    func txt(s: String) -> Self {
        text = s
        return self
    }
    
    @discardableResult
    func txtcol(c: UIColor) -> Self {
        textColor = c
        return self
    }
    
    @discardableResult
    func txtFont(f: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: f)
        return self
    }
    
    @discardableResult
    func txt(s : String, fon: CGFloat, cor: String) -> Self {
        textColor = UIColor(hexString: cor)
        font = UIFont.systemFont(ofSize: fon)
        text = s
        return self
    }
}

public typealias BtnAction = (UIButton)->()
public extension UIButton{
   private struct AssociatedKeys{
      static var actionKey = "actionKey"
   }
    
    static func custom() -> UIButton {
        return UIButton(type: .custom)
    }
    
    
    @discardableResult
    func normalTitle(txt: String) -> UIButton {
        setTitle(txt, for: .normal)
        return self
    }

    @discardableResult
    func fontSize(size: CGFloat) -> UIButton {
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        return self
    }
    @discardableResult
    func txtColor(col: UIColor) -> UIButton {
        setTitleColor(col, for: .normal)
        return self
    }

    
    @discardableResult
    func selectTitle(txt: String) -> UIButton {
        setTitle(txt, for: .selected)
        return self
    }
 
    @discardableResult
    func normalImage(name: String) -> UIButton {
        setImage(UIImage(named: name), for: .normal)
        return self
    }
    
    @discardableResult
    func selectedImage(name: String) -> UIButton {
        setImage(UIImage(named: name), for: .selected)
        return self
    }
    
    @objc dynamic var action: BtnAction? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let action = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? BtnAction{
                return action
            }
            return nil
        }
    }

    @discardableResult
    func addUpInsideAction(action:@escaping  BtnAction) -> UIButton {
        self.action = action
        self.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
        return self
    }

    @objc func touchUpInSideBtnAction(btn: UIButton) {
        if let action = self.action {
            action(self)
        }
    }
}

extension UIButton {
    @discardableResult
    func imageRight() -> Self {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return self
    }
}
