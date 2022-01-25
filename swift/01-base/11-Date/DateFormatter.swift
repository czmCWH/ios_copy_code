/*
 
 [Introduction to Data Formatting Programming Guide For Cocoa](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029-CJBCGJCJ)
 
 https://cloud.tencent.com/developer/article/1764197
 https://swift.gg/2015/12/14/a-beginners-guide-to-nsdate-in-swift/
 https://www.jianshu.com/p/09df1a07dc12
 
 */

// MARK: - DateFormatter 基本使用

// MARK: 返回当前系统时间的不同样式

do {
    let dateFmt = DateFormatter()
    
    /*
     设置返回的 日期样式
        .short：2021/12/3
        .medium：2021年12月3日
        .long：2021年12月3日
        .full：2021年12月3日 星期五
     */
    dateFmt.dateStyle = .long
    
    /*
     设置返回的 时间样式
        .short：下午3:09
        .medium：下午3:09:55
        .long：GMT+8 下午3:10:23
        .full：中国标准时间 下午3:10:59
     */
    dateFmt.timeStyle = .full
    
    // .medium 和 .long对中文来说没区别
    
    print("=====", dateFmt.string(from: Date()))
}

// MARK: 返回当前系统北京时间

// dateFormat 和 dateStyle/timeStyle 互斥，代码前后顺序会相互覆盖

do {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    // 用于区别于地域的日期显示，不同语言的显示
    let locale = Locale(identifier: "zh_CN")
    dateFormatter.locale = locale
    
    // TimeZone.knownTimeZoneIdentifiers 列出系统已知的所有时区的 ID
    // TimeZone.current.identifier  获取系统设置的时区 ID
    let timeZone = TimeZone(identifier: "Asia/Shanghai")
    // 指定时区，如果未指定，则使用 系统设置中 的时区
    dateFormatter.timeZone = timeZone
    
    // 当前北京时间
    let cnDateStr = dateFormatter.string(from: Date())
}

// MARK: - ISO8601DateFormatter 基本使用

// ISO8601DateFormatter 用于转换 GO 语言返回的时间奇葩时间如："2018-04-12T09:00:48+08:00"

// 一般转换如下：

do {
    // 把 RFC3339 时间格式转换为Date 参考：https://studygolang.com/articles/338
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")    // 时间本地化
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"     // 格式
    formatter.timeZone   = TimeZone(secondsFromGMT: 0) // 时区
    
    let start = "2018-04-12T09:00:48+08:00"
    if let date = formatter.date(from: start) {
        print("==czm===", date)
    }
}


// 通过 ISO8601DateFormatter 转换如下：

do {
    let start = "2018-04-12T09:00:48+08:00"
    let fmt = ISO8601DateFormatter()
    let startD = fmt.date(from: start)
}
