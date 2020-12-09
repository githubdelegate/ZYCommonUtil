//
//  NSObjectUtil.swift
//  cleaner
//
//  Created by zy on 2020/7/16.
//  Copyright © 2020 topstack. All rights reserved.
//

import Foundation
import ObjectiveC
    
public extension NSObject {
    func setAssociated<T>(value: T, associatedKey: UnsafeRawPointer, policy: objc_AssociationPolicy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) -> Void {
        objc_setAssociatedObject(self, associatedKey, value, policy)
    }
    
    func getAssociated<T>(associatedKey: UnsafeRawPointer) -> T? {
        let value = objc_getAssociatedObject(self, associatedKey) as? T
        return value;
    }
}

public extension NSObject{
    class var nameOfClass: String?{
        if let n = NSStringFromClass(self).components(separatedBy: ".").last {
            return n
        } else {
            return nil
        }
    }
}
