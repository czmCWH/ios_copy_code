//
//  BannerCell.swift
//  AppDemo
//
//  Created by haozhongliang on 2021/5/8.
//

import UIKit

class BannerCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .randomColor
    }

}

extension UIColor {
    open class var randomColor: UIColor {
        return UIColor.init(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
}
