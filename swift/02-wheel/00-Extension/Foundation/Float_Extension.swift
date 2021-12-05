//
//  Float_extension.swift
//  test01
//
//  Created by czm on 2021/12/5.
//

import Foundation


extension Float {
 
    // 小数点后如果只是0，显示整数，如果不是，显示原来的值
    // https://blog.csdn.net/may_he/article/details/84835572
    var cleanZero : String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
 
}
