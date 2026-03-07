import Foundation

/// 将 Int 转换为 TimeInterval
/// 例如：1.days 表示 1 天
/// 如果进一步想表示 Date
/// - 1.day.ago 表示 1 天前的时间
/// - 3.day.later 表示 3 天后的时间
extension Int {
    var days: TimeInterval { .days(self) }
    var day: TimeInterval { .days(1) }
    
    var hours: TimeInterval { .hours(self) }
    var hour: TimeInterval { .hours(1) }
    
    var minutes: TimeInterval { .minutes(self) }
    var minute: TimeInterval { .minutes(1) }

    var seconds: TimeInterval { .seconds(self) }
    var second: TimeInterval { .seconds(1) }

    var weeks: TimeInterval { .weeks(self) }
    var week: TimeInterval { .weeks(1) }

    var months: TimeInterval { .months(self) }
    var month: TimeInterval { .months(1) }

    var years: TimeInterval { .years(self) }
    var year: TimeInterval { .years(1) }    
}

extension Int {
    /// 将秒数转换为 时:分:秒 格式
    /// 常用于音频播放器、倒计时功能，将总秒数转换为 01:23:45 格式
    /// 使用示例:
    /// - print(3665.toTimeString()) // 输出 "01:01:05
    func toTimeString() -> String {
        guard self > 0 else { return "00:00" }
        
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}

/// 执行多次操作
extension Int {
    // 执行多次操作 (循环执行闭包)
    /// 使用示例:
    /// 3.times { print("Hello") } // 输出 "Hello" 3 次
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            closure()
        }
    }
    
    // 带索引的循环 (循环执行闭包，并传递索引)
    /// 使用示例:
    /// - 3.times { index in print("Hello \(index)") } // 输出 "Hello 0" "Hello 1" "Hello 2"
    func times(_ closure: (Int) -> Void) {
        guard self > 0 else { return }
        for i in 0..<self {
            closure(i)
        }
    }
}
