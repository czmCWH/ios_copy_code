//
//  Extensions.swift
//  UICircularProgressRing
//
//  Created by Luis on 2/5/19.
//  Copyright © 2019 Luis Padron. All rights reserved.
//

/**
 * This file includes internal extensions.
 */

import UIKit


/**
 提供简单的从度到弧度的转换
 */
extension CGFloat {
    var rads: CGFloat { return self * CGFloat.pi / 180 }
}

extension CGFloat {
    var interval: TimeInterval { return TimeInterval(self) }
}

extension TimeInterval {
    var float: CGFloat { return CGFloat(self) }
}


