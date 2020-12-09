//
//  ArrayUtils.swift
//  cleaner
//
//  Created by zy on 2020/7/3.
//  Copyright © 2020 topstack. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
    func safeIndex(of object: Element) -> Int {
        guard let index = firstIndex(of: object) else { return  -1 }
        return index
    }
}

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

