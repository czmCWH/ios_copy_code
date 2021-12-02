//
//  ZMHitButton.swift
//  Kiddos
//
//  Created by czm on 2021/8/19.
//

import UIKit

class ZMHitButton: UIButton {

    /// 各个边界扩张的范围：UIEdgeInsets(top: , left: , bottom: , right: )
    var zmhitEdgeInsets: UIEdgeInsets?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let zmhitEdgeInsets = zmhitEdgeInsets {
            var newBounds = self.bounds;
            
            newBounds.size.width += zmhitEdgeInsets.right;
            newBounds.origin.x -= zmhitEdgeInsets.left;
            
            newBounds.size.height += zmhitEdgeInsets.bottom;
            newBounds.origin.y -= zmhitEdgeInsets.top;
            
            return newBounds.contains(point);
        } else {
            return super.point(inside: point, with: event)
        }
    }

}
