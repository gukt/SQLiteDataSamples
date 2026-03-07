import Foundation

// MARK: - 将 Date 转换为 String 格式

extension Date {
    /// 将 Date 转换为 String 格式为 "yyyy-MM-dd HH:mm:ss"
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    // MARK: - 常用格式化快捷方式

    /// 返回格式为 "yyyy-MM-dd" 的 String
    /// 要想返回 yyyy-MM-dd HH:mm:ss 的 String，请使用 toString(format: "yyyy-MM-dd HH:mm:ss")
    func ymd() -> String {
        return toString(format: "yyyy-MM-dd")
    }

    /// 返回格式为 "yyyy-MM-dd HH:mm" 的 String
    func ymdhm() -> String {
        return toString(format: "yyyy-MM-dd HH:mm")
    }

    func ymdh() -> String {
        return toString(format: "yyyy-MM-dd HH")
    }
}

// MARK: - 直接获取年、月、日、时、分、秒，或者星期几

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }

    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }

    // 判断是否是今天/昨天/明天
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
}

// MARK: - 日期范围 (开始与结束)

/// 获取 “今天的开始时间（00:00:00）” 或 “本月的最后一天”
extension Date {
    // 当天的开始 (00:00:00)
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    // 当天的结束 (23:59:59)
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

// MARK: - 本月的第一天 & 最后一天

/// 获取 “本月的第一天（00:00:00）” 或 “本月的最后一天”
extension Date {
    // 本月的第一天（00:00:00）
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }

    // 本月的最后一天（00:00:00）
    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
    }
}

// MARK: - 时间差计算

extension Date {
    /// 从 self 到现在经过了多少天（绝对值）
    /// 例如：lastWateredDate.daysAgo() 返回 7 表示 7 天前浇的水
    func daysAgo() -> Int {
        let days = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
        return abs(days)
    }
    
    /// 从现在到 self 还有多少天（可能为负）
    /// - 正数：未来（例如 3 表示 3 天后）
    /// - 负数：过去（例如 -2 表示 2 天前）
    /// - 零：今天
    func daysUntilNow() -> Int {
        return Calendar.current.dateComponents([.day], from: Date(), to: self).day ?? 0
    }
    
    /// 计算两个日期之间的天数差
    func days(to date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: date).day ?? 0
    }
    
    // 同理，小时和分钟
    func hoursAgo() -> Int {
        let hours = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
        return abs(hours)
    }
    
    func minutesAgo() -> Int {
        let minutes = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
        return abs(minutes)
    }
}