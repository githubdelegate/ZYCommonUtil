//
//  Number+Util.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation


public extension Float {
    
    /// 保留小数点后两位输出string
    /// - Returns: description
    func point2Str() -> String {
        let str = String(format: "%.2f", self)
        return str
    }
    
    
    /// 根据大小返回磁盘大小描述
    /// - Returns: description
    func memorySizeString() -> String {
        if self < 0 {
            return "0KB"
        }
        
        if self > 1 {
            if self >= 1000 {
                let r = self / 1000.0
                return "\(r.point2Str())GB"
            } else {
                return "\(self.point2Str())MB"
            }
        } else {
            return "\((self * 1000).point2Str())KB"
        }
    }
}
