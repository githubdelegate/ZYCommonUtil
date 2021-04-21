//
//  String+Util.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit


public extension String {
    func zy_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func zy_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func zy_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}


public extension NSAttributedString {
    /// 获取string文字size
    /// - Returns: description
    func getSize() -> CGSize {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        lable.attributedText = self
        lable.sizeToFit()
        return lable.frame.size
    }
}

public extension String {
    var url: URL {
        if let u = URL(string: self)  {
            return u
        }
        
        if let u = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let ur = URL(string: u) {
                return ur
            }
        }
        return URL(string: "https://www.google.com")!
    }
}


// for language
public extension String {
    var local: String {
        return NSLocalizedString(self, comment: "")
    }
}


public extension Character {
    var isPureInteger: Bool {
        let s =  String(self)
        let scan = Scanner(string: s)
        var v: Int = 0
        return scan.scanInt(&v) && scan.isAtEnd
    }
}

/// 判断类型
public extension String {
    var isValidValidVCard: Bool {
        let r = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return r.hasPrefix("BEGIN:VCARD")
    }
    
    var isValidWebUrl: Bool {
        let r = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if r.isEmpty {
            return false
        }
        
        guard let url = URL(string: r) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    var isValidPhoneNumber: Bool {
        let r = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let systemCharArr: [String] = ["(", ")", "+", "*", "-", "#", ";", " ", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let filterStr: String = r.filter {
            !systemCharArr.contains(String($0))
        }
        
        if !filterStr.isEmpty {
            return false
        }
        
        let ns = r.filter {
            $0.isPureInteger
        }
        
        if ns.count >= 3, ns.count <= 20 {
            return true
        }
        return false
    }
    
    var isValidEmail: Bool {
        let r = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regular = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z.]{2,10}"
        let filter: NSPredicate = NSPredicate(format: "SELF MATCHES%@", regular)
        return filter.evaluate(with: r)
    }
}

public extension String {
    var fileUrl: URL {
        return URL(fileURLWithPath: self)
    }
}
