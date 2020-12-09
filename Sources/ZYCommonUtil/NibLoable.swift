//
//  File.swift
//  
//
//  Created by edz on 2020/12/9.
//

import Foundation
import UIKit

public protocol NibLoadableProtocol {
}

// nib 加载 文件名 要一样
public extension NibLoadableProtocol {
    static func instanceFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last! as! Self
    }
}


public protocol StoryboardableProtocol: UIViewController {
    static func vcInstanceFromStoryboard() -> Self
    static var storyboardName: String { get }
}

public extension StoryboardableProtocol {
    
    static var storyboardName: String { return "Main" }
    
    static func vcInstanceFromStoryboard() -> Self {
//        if let n = name {
        let s = UIStoryboard.init(name: Self.storyboardName, bundle: nil)
            return s.instantiateViewController(withIdentifier: self.nameOfClass ?? "") as! Self
//        } else {
//            let s = UIStoryboard.init(name: "Main", bundle: nil)
//            return s.instantiateViewController(withIdentifier: self.nameOfClass ?? "") as! Self
//        }
    }
}
