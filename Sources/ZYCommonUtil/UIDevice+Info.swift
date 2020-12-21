//
//  UIDevice+Info.swift
//  cleaner
//
//  Created by zy on 2020/9/4.
//  Copyright © 2020 gramm. All rights reserved.
//

import Foundation
import UIKit

public enum LocalLanguage {
    case en,cn
}

public extension UIDevice {
    /// 判断当前设备的语言， 只支持 中文和英文
    /// - Returns: description
    func getLanguageType() -> LocalLanguage {
        let def = UserDefaults.standard
        let allLanguages: [String] = def.object(forKey: "AppleLanguages") as! [String]
        let chooseLanguage = allLanguages.first
        
        guard chooseLanguage != nil  else {
            return .en
        }
        
        if chooseLanguage!.hasPrefix("en") {
            return .en
        } else {
            return .cn
        }
    }
}

public extension UIDevice {
    var isCurrentEn: Bool {
        guard let lans = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] else {
            return true
        }
        
        if lans.first == "en" {
            return true
        }
        
        return false
    }
    
    var isCurrentSimpleChina: Bool {
        guard let lans = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] else {
            return true
        }
        if lans.first == "zh-Hans-CN" {
            return true
        }
        return false
    }
}

//public extension UIDevice {
//    func MBFormatter(_ bytes: Int64) -> String {
//        let formatter = ByteCountFormatter()
//        formatter.allowedUnits = ByteCountFormatter.Units.useMB
//        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
//        formatter.includesUnit = false
//        return formatter.string(fromByteCount: bytes) as String
//    }
//
//    // MARK: Get String Value
//
//    var totalDiskSpaceInGB: String {
//        return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
//    }
//
//    var freeDiskSpaceInGB: String {
//        return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
//    }
//
//    var usedDiskSpaceInGB: String {
//        return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.decimal)
//    }
//
//    var totalDiskSpaceInMB: String {
//        return MBFormatter(totalDiskSpaceInBytes)
//    }
//
//    var freeDiskSpaceInMB: String {
//        return MBFormatter(freeDiskSpaceInBytes)
//    }
//
//    var usedDiskSpaceInMB: String {
//        return MBFormatter(usedDiskSpaceInBytes)
//    }
//
//    var diskUsageRate: Float {
//        return Float(usedDiskSpaceInBytes) / Float(totalDiskSpaceInBytes)
//    }
//
//    var freeGB: String {
//        return String(format: "%.0f", freeDiskGB) + "GB"
//    }
//
//    var usedGB: String {
//        return String(format: "%.0f", usedDiskGB) + "GB"
//    }
//
//
//
//    var totalDiskGB: Float {
//        return (Float(totalDiskSpaceInBytes) / (1000.0 * 1000.0 * 1000.0))
//    }
//
//    var freeDiskGB: Float {
//        return (Float(freeDiskSpaceInBytes) / (1000.0 * 1000.0 * 1000.0))
//    }
//
//    var usedDiskGB: Float {
//        return (Float(usedDiskSpaceInBytes) / (1000.0 * 1000.0 * 1000.0))
//    }
//
//    // MARK: Get raw value
//
//    var totalDiskSpaceInBytes: Int64 {
//        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
//            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
//        return space
//    }
//
//    /*
//     Total available capacity in bytes for "Important" resources, including space expected to be cleared by purging non-essential and cached resources. "Important" means something that the user or application clearly expects to be present on the local system, but is ultimately replaceable. This would include items that the user has explicitly requested via the UI, and resources that an application requires in order to provide functionality.
//     Examples: A video that the user has explicitly requested to watch but has not yet finished watching or an audio file that the user has requested to download.
//     This value should not be used in determining if there is room for an irreplaceable resource. In the case of irreplaceable resources, always attempt to save the resource regardless of available capacity and handle failure as gracefully as possible.
//     */
//    var freeDiskSpaceInBytes: Int64 {
//        if #available(iOS 11.0, *) {
//            if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
//                return space
//            } else {
//                return 0
//            }
//        } else {
//            if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
//                let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
//                return freeSpace
//            } else {
//                return 0
//            }
//        }
//    }
//
//    var usedDiskSpaceInBytes: Int64 {
//        return totalDiskSpaceInBytes - freeDiskSpaceInBytes
//    }
//}

//public extension UIDevice {
//    func ramUsage() -> (UInt64, Int64, Int64, Float) {
//        let v = ProcessInfo.processInfo.physicalMemory
//        print("\(v)")
//
//        var pagesize: vm_size_t = 0
//
//        let host_port: mach_port_t = mach_host_self()
//        var host_size: mach_msg_type_number_t = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.stride / MemoryLayout<integer_t>.stride)
//        host_page_size(host_port, &pagesize)
//
//        var vm_stat: vm_statistics = vm_statistics_data_t()
//        withUnsafeMutablePointer(to: &vm_stat) { (vmStatPointer) -> Void in
//            vmStatPointer.withMemoryRebound(to: integer_t.self, capacity: Int(host_size)) {
//                if host_statistics(host_port, HOST_VM_INFO, $0, &host_size) != KERN_SUCCESS {
//                    //                    NSLog("Error: Failed to fetch vm statistics")
//                }
//            }
//        }
//
//        /* Stats in bytes */
//        let mem_used: Int64 = Int64(vm_stat.active_count +
//            vm_stat.inactive_count +
//            vm_stat.wire_count) * Int64(pagesize)
//        let mem_free: Int64 = Int64(vm_stat.free_count) * Int64(pagesize)
//
//        print("打印内存使用量 \(mem_used) --\(mem_free)")
//        return (v, mem_used, mem_free, Float(mem_used) / Float(v))
//    }
//
//    func cpuUsage() -> Float {
//        let CPUUsageLock: NSLock = NSLock()
//        var cpuInfo: processor_info_array_t!
//        var prevCpuInfo: processor_info_array_t?
//        var numCpuInfo: mach_msg_type_number_t = 0
//        var numPrevCpuInfo: mach_msg_type_number_t = 0
//        let numCPUs: uint = 0
//        var numCPUsU: natural_t = 0
//        var totalUsage: Float = 0.0
//        let err: kern_return_t = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &cpuInfo, &numCpuInfo)
//        if err == KERN_SUCCESS {
//            CPUUsageLock.lock()
//
//            for i in 0 ..< Int32(numCPUs) {
//                var inUse: Int32
//                var total: Int32
//                if let prevCpuInfo = prevCpuInfo {
//                    inUse = cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_USER)]
//                        - prevCpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_USER)]
//                        + cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_SYSTEM)]
//                        - prevCpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_SYSTEM)]
//                        + cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_NICE)]
//                        - prevCpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_NICE)]
//                    total = inUse + (cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_IDLE)]
//                        - prevCpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_IDLE)])
//                } else {
//                    inUse = cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_USER)]
//                        + cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_SYSTEM)]
//                        + cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_NICE)]
//                    total = inUse + cpuInfo[Int(CPU_STATE_MAX * i + CPU_STATE_IDLE)]
//                }
//
//                print(String(format: "Core: %u Usage: %f", i, Float(inUse) / Float(total)))
//                totalUsage = totalUsage + (Float(inUse) / Float(total))
//            }
//            CPUUsageLock.unlock()
//
//            if let prevCpuInfo = prevCpuInfo {
//                // vm_deallocate Swift usage credit rsfinn: https://stackoverflow.com/a/48630296/1033581
//                let prevCpuInfoSize: size_t = MemoryLayout<integer_t>.stride * Int(numPrevCpuInfo)
//                vm_deallocate(mach_task_self_, vm_address_t(bitPattern: prevCpuInfo), vm_size_t(prevCpuInfoSize))
//            }
//
//            prevCpuInfo = cpuInfo
//            numPrevCpuInfo = numCpuInfo
//
//            cpuInfo = nil
//            numCpuInfo = 0
//            return totalUsage
//        } else {
//            print("Error!")
//            return 0.0
//        }
//    }
//}
