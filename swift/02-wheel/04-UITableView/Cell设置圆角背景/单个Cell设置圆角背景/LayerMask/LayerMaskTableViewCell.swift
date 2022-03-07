//
//  LayerMaskTableViewCell.swift
//  单个Cell设置圆角背景
//
//  Created by czm on 2022/2/18.
//

import UIKit

class LayerMaskTableViewCell: UITableViewCell {

    enum Position {
        case solo   // 单个
        case first  // 第一个
        case middle // 中间一个
        case last   // 末尾一个
    }
    var position: Position = .middle

    let bgShapLayer = CAShapeLayer()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        bgShapLayer.backgroundColor = UIColor.white.cgColor
        self.contentView.layer.addSublayer(bgShapLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        adjustMyFrame()
        self.bgShapLayer.frame = CGRect(x: 15, y: 0, width: self.frame.width - 30, height: self.frame.height)
        setCorners()
    }
    func setCorners() {
        let cornerRadius: CGFloat = 6.0
        switch position {
        case .solo: addRoundCorners(corners: .allCorners, radius: cornerRadius)
        case .first: addRoundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
        case .last: addRoundCorners(corners: [.bottomLeft, .bottomRight], radius: cornerRadius)
        default: removeRoundCorners()
        }
    }
    
    func addRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskFrame = self.bgShapLayer.bounds
        let path = UIBezierPath(roundedRect: maskFrame, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.bgShapLayer.mask = mask
    }
    
    func removeRoundCorners() {
        self.layer.mask = nil
    }

}

