//
//  Date+Util.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation

public extension Date {
    var dayString: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let dateStr = df.string(from: self)
            return dateStr
        }
    }
    
    var secondsString: String {
        get {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateStr = df.string(from: self)
            return dateStr
        }
    }
    
    
    /// 当前时间是不是比date早
    /// - Parameter date: date description
    /// - Returns: description
    func isEarlier(than date: Date) -> Bool {
        if self.timeIntervalSince(date) < 0 {
            return true
        }
        return false
    }
    
    
    /// 比当前时间早
    var isEarlierNow: Bool {
        return self.isEarlier(than: Date())
    }
    
    /// 判断两个日期是不是同一天
    /// - Parameter anthor: anthor description
    /// - Returns: description
    func isSameDay(with anthor: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: anthor)
    }
}
