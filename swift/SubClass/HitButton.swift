//
//  HitButton.swift
//  power-coolene
//
//  Created by dong on 2020/11/23.
//
// 用于处理：扩大UIButton的点击范围

import UIKit

class HitButton: UIButton {
    
    /// 延展的宽度( 左+右 )
    var stretchW: CGFloat = 0.0
    
    /// 延展的高度( 上+下 )
    var stretchH: CGFloat = 0.0

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        var newBounds = self.bounds
        newBounds.size.width += stretchW
        newBounds.origin.x -= stretchW * 0.5
        
        newBounds.size.height += stretchH
        newBounds.origin.y -= stretchH * 0.5
        return newBounds.contains(point)
    }
    
}
