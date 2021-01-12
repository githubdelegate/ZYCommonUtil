//
//  File.swift
//  
//
//  Created by edz on 2021/1/12.
//

import Foundation
import UIKit

public extension UIScreen {
    static var width: Float {
        return Float(UIScreen.main.bounds.size.width)
    }
    
    static var height: Float {
        return Float(UIScreen.main.bounds.size.height)
    }
}
