//
//  TimeInterval+Extensions.swift
//  GreenTime
//
//  Created by Gu Kaitong  on 2026/1/26.
//

import Foundation

/// TimeInterval + Int 扩展
extension TimeInterval {
    // MARK: - 定义基础单位

    static var second: TimeInterval { 1 }
    static var minute: TimeInterval { 60 * .second }
    static var hour: TimeInterval { 60 * .minute }
    static var day: TimeInterval { 24 * .hour }
    static var week: TimeInterval { 7 * .day }
    static var month: TimeInterval { 30 * .day }
    static var year: TimeInterval { 365 * .day }

    // MARK: - 定义倍数计算 (例如 2.days)

    static func days(_ value: Int) -> TimeInterval { TimeInterval(value) * .day }
    static func hours(_ value: Int) -> TimeInterval { TimeInterval(value) * .hour }
    static func minutes(_ value: Int) -> TimeInterval { TimeInterval(value) * .minute }
    static func seconds(_ value: Int) -> TimeInterval { TimeInterval(value) * .second }
    static func weeks(_ value: Int) -> TimeInterval { TimeInterval(value) * .week }
    static func months(_ value: Int) -> TimeInterval { TimeInterval(value) * .month }
    static func years(_ value: Int) -> TimeInterval { TimeInterval(value) * .year }

    // MARK: - 定义时间方向 (例如 .ago)
    
    /// 表示过去或未来的时间
    /// 用法：
    /// - 2.days.ago
    /// - 5.days.later
    var ago: Date { Date() - self }
    var later: Date { Date() + self }
}
