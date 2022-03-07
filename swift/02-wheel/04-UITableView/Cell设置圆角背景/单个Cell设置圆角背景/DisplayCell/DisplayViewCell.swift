//
//  DisplayViewCell.swift
//  单个Cell设置圆角背景
//
//  Created by czm on 2022/2/20.
//

import UIKit

class DisplayViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

/* 设置cell边距，修改cell的frame
 https://blog.csdn.net/zWbKingGo/article/details/106218157
 override var frame: CGRect {
         didSet {
             var newFrame = frame
             newFrame.origin.x += 10
             newFrame.size.width -= 20
             super.frame = newFrame
         }
     
 }
 */


