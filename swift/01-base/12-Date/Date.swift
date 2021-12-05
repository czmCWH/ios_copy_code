/*
 
 [About Dates and Times](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/DatesAndTimes.html#//apple_ref/doc/uid/10000039i)
 
 NSDate 及其子类将时间计算为相对于绝对参考日期的秒数。此参考日期是格林威治标准时间 (GMT) 2001 年 1 月 1 日的第一个瞬间。
 
 */

// 1、获取当前时间对象
if #available(iOS 15, *) {
    Date.now
} else {
    Date()
}

// 2、Date初始化

// 返回当前时间偏移秒数的 Date对象

do {
    // 当前时间的昨天：
    let aDate = Date(timeIntervalSinceNow: -60*60*24)
    
    // 当前时间的明天：
    let aDate = Date(timeIntervalSinceNow: 60*60*24)
    
    // 返回相对于 aDate 时间对象加减秒数的时间对象
    let aDate = Date(timeInterval: 60*60, since: aDate)
}

// 时间戳秒数转换为 Date对象
do {
    let milliseconds: TimeInterval = 1638527627000
    let aDate = Date(timeIntervalSince1970: milliseconds/1000.0)
}

// 把时间字符串转换为 Date对象
do {
    let date: Date? = Date("2021-12-05 07:34:57")
}


// 3、Date对象 之间间隔多少秒

do {
    // 返回日期值与1970年1月1日00:00:00 UTC之间的间隔秒数，即当前时间戳秒数
    let interval = Date().timeIntervalSince1970

    // 返回日期值与2001年1月1日00:00:00 UTC之间的间隔秒数
    let interval = Date().timeIntervalSinceReferenceDate
}

// 两个时间对象之间间隔的秒数
do {
    let aDate = Date("2021-12-05 10:30:00")!
    let anDate = Date("2021-12-05 10:31:00")!
    
    if #available(iOS 13.0, *) {
        print(anDate.distance(to: aDate))       // 打印：-60
    } else {
        print(aDate.timeIntervalSince(anDate))      // 打印：-60
    }
}


// 4、 Date对象 的计算

// 把Date对象 增加60秒
do {
    var anDate = Date("2021-12-05 10:31:00")!
    print(anDate)
    anDate.addTimeInterval(60)      // 改变原来的Date对象的值
    print(anDate)
    
    let aDate = Date("2021-12-05 10:31:00")!
    if #available(iOS 13.0, *) {
        print(aDate.advanced(by: 60))       // 打印：2021-12-05 10:32:00 +0000
    } else {
        print(aDate.addingTimeInterval(60))        // 打印：2021-12-05 10:32:00 +0000
    }
}

// 5、Date对象 支持运算符

do {
    let aDate = Date("2021-12-05 10:31:00")!
    var anDate = Date("2021-12-05 10:31:00")!
    
    print(aDate == anDate)      // 打印：true
    
    anDate = Date("2021-12-06 10:31:00")!
    print(aDate < anDate)   // 打印：true
    
    anDate += 60
    print(anDate)   // 打印：2021-12-06 10:32:00 +0000
}
