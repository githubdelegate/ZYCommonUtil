//
//  File.swift
//  
//
//  Created by edz on 2021/1/12.
//

import Foundation
//import UIKit
//
//protocol NibLoadableProtocol {
//
//}
//
//extension NibLoadableProtocol {
//    static func instanceFromNib() -> Self {
//        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last! as! Self
//    }
//}
//
//protocol StoryboardableProtocol: UIViewController {
//    static func vcInstanceFromStoryboard(name: String?) -> Self
//}
//
//extension StoryboardableProtocol {
//    static func vcInstanceFromStoryboard(name: String?) -> Self {
//        if let n = name {
//             let s = UIStoryboard.init(name: n, bundle: nil)
//            return s.instantiateViewController(withIdentifier: self.nameOfClass ?? "") as! Self
//        } else {
//            let s = UIStoryboard.init(name: "Main", bundle: nil)
//            return s.instantiateViewController(withIdentifier: self.nameOfClass ?? "") as! Self
//        }
//    }
//}
