//
//  Double_Extension.swift
//  test01
//
//  Created by czm on 2022/5/31.
//

import Foundation

enum DoubleCalculateType {
    case add
    case subtract
    case multiply
    case divide
}

// 浮点数基本运算，精度问题处理
extension Double {
    
    var decimal: NSDecimalNumber {
        return NSDecimalNumber(value: self)
    }

    /// 浮点数比较
    /// - Parameter byValue: 运算的值
    /// - Returns: let res = a.compare(b)。res 为 0，a和b相等；res 为 -1，a小于b；res 为 1，a大于b；
    func compare(_ byValue: Self) -> Int {
        switch self.decimal.compare(byValue.decimal) {
        case .orderedSame:  // 相等, a == b
            return 0
        case .orderedAscending:     // 升序，小于，a<b
            return -1
        case .orderedDescending:    // 降序，大于，a>b
            return 1
        }
    }
    
    /// 浮点数算数计算
    func calculate(_ byValue: Self, _ actionType: DoubleCalculateType, _ roundingMode: NSDecimalNumber.RoundingMode?, _ scale: Int16 = 2) -> Self {
        let decimalA = self.decimal
        let decimalB = byValue.decimal
        let behavior = self.getConfigBehavior(roundingMode ?? .plain, scale)
        
        // 通过 String 类型间接转换下结果，避免精度问题
        // decimalA.subtracting(decimalB).doubleValue
        let resultStr: String
        switch actionType {
        case .add:
            resultStr = decimalA.adding(decimalB, withBehavior: behavior).stringValue
        case .subtract:
            resultStr = decimalA.subtracting(decimalB, withBehavior: behavior).stringValue
        case .multiply:
            resultStr = decimalA.multiplying(by: decimalB, withBehavior: behavior).stringValue
        case .divide:
            resultStr = decimalA.dividing(by: decimalB, withBehavior: behavior).stringValue
        }
//        resultStr.components(separatedBy: ".")
        return NumberFormatter().number(from: resultStr)?.doubleValue ?? 0.0
    }
    
    /// Double 转 String，保留小数点后n位，默认2位
    func toDotStr(_ place: Int = 2) -> String {
        return String(format:"%.\(place)f", self)
    }

    /// 配置默认的 Behavior，例如遇到 数值溢出、除数为0，计算不会崩溃，而是返回 0.00
    private func getConfigBehavior(_ buyMode: NSDecimalNumber.RoundingMode, _ buyScale: Int16) -> NSDecimalNumberHandler {
        let behavior = NSDecimalNumberHandler(roundingMode: buyMode, scale: buyScale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return behavior
    }
}
