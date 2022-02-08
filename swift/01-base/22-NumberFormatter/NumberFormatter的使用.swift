/*
    NumberFormatter 的使用
 https://www.jianshu.com/p/7ea8506e7892
 */

do {
    let numFormat = NumberFormatter()
    /* 可参考Apple官方文档：https://developer.apple.com/documentation/foundation/numberformatter/style
     case none = 0
     case decimal = 1
     case currency = 2
     case percent = 3
     case scientific = 4
     case spellOut = 5
     case ordinal = 6
     case currencyISOCode = 8
     case currencyPlural = 9
     case currencyAccounting = 10
     */
    numFormat.numberStyle = .decimal
    numFormat.positiveFormat = "###,##0.00"
    let amountStr = numFormat.string(from: NSNumber(value: 123123.02300000))
    print(amountStr)    // 打印：Optional("123,123.02")
}
