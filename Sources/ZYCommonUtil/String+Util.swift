//
//  String+Util.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit

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

extension String {
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
extension String {
    var local: String {
        return NSLocalizedString(self, comment: "")
    }
}
