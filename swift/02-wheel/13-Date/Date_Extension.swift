
import Foundation

extension Date {
    
    static let sharedFmt = DateFormatter()
    
    /// 返回指定格式的北京时间
    func timeUTC8FormatterStr(_ mftStr: String) -> String {
        Date.sharedFmt.locale = Locale(identifier: "zh_CN")
        Date.sharedFmt.timeZone = TimeZone(identifier: "Asia/Shanghai")
        Date.sharedFmt.dateFormat = mftStr
        return Date.sharedFmt.string(from: self)
    }
    
    // MARK: - 基本日期格式转换
    
    /// 返回完整北京时间
    /// - Returns: 默认格式："yyyy-MM-dd HH:mm:ss"
    func timeZHFull(_ mftStr: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return timeUTC8FormatterStr(mftStr)
    }
    
    /// 返回北京时间 日期 (年 月 日)
    /// - Returns: 默认返回： "yyyy-MM-dd"
    func timeZHDate(_ mftStr: String = "yyyy-MM-dd") -> String {
        return timeUTC8FormatterStr(mftStr)
    }
    
    /// 返回北京时间 时间 (时 分 秒)
    /// - Returns: 默认返回： "HH:mm:ss"
    func timeZHTime(_ mftStr: String = "HH:mm:ss") -> String {
        return timeUTC8FormatterStr(mftStr)
    }
    
    /// 返回北京时间 小时
    /// - Returns: 默认返回："HH:mm"
    func timeZHHour(_ mftStr: String = "HH:mm") -> String {
        return timeUTC8FormatterStr(mftStr)
    }
    
}


