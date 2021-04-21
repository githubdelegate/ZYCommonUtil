//
//  File.swift
//  
//
//  Created by edz on 2021/4/21.
//

import Foundation

public extension URL {
    static var documentPath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
