//
//  CountDownModel.swift
//  test01
//
//  Created by czm on 2022/2/21.
//

import UIKit

class CountDownModel: NSObject {
    
    var idx: Int = 0
    var num: Int = 0
    
    init(_ count: Int) {
        num = count
        super.init()
    }
    
}
