//
//  LayoutButton.swift
//  power-coolene
//

// https://juejin.cn/post/6844904149784477703
//  Created by dong on 2020/11/23.
//

import UIKit

class LayoutButton: UIButton {
    
    enum PositionType {
        case left, right, top, bottom
    }

    convenience init(frame: CGRect, type: PositionType, normalImg: UIImage?, highlightImg: UIImage?, title: String?, margin: CGFloat = 0.0) {
        self.init(type: .custom)
        
        setImage(normalImg, for: .normal)
        setImage(highlightImg, for: .highlighted)
        setTitle(title, for: .normal)
        
        let marginHV = margin
        let titleSize = titleLabel?.intrinsicContentSize ?? .zero
        let imgSize = imageView?.frame.size ?? .zero
        let btnSize = self.frame.size
        
        if frame.isEmpty {
            switch type {
            case .right, .left:
                self.frame = CGRect(x: 0, y: 0, width: titleSize.width + imgSize.width + margin, height: 50)
            default:
                self.frame = CGRect(x: 0, y: 0, width: 100, height: titleSize.height + imgSize.height + margin)
            }
        }
        
        var titleInsets = UIEdgeInsets.zero;
        var imgInsets = UIEdgeInsets.zero;
        
        switch type {
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: -(titleSize.width + imgSize.width), bottom: 0, right: 0)
            imgInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width + imgSize.width + marginHV))
        case .top:
            let topBottomH = (btnSize.height - titleSize.height - imgSize.height - marginHV) * 0.5;
            titleInsets = UIEdgeInsets(top: topBottomH, left: (btnSize.width - titleSize.width)/2.0 - imgSize.width, bottom: topBottomH + marginHV + imgSize.height, right: (btnSize.width - titleSize.width)/2.0)
            
            imgInsets = UIEdgeInsets(top: topBottomH + marginHV + titleSize.height, left: (btnSize.width - imgSize.width)/2.0, bottom: topBottomH, right: (btnSize.width - imgSize.width)/2.0 - titleSize.width)
        case .bottom:
            let topBottomH = (btnSize.height - titleSize.height - imgSize.height - marginHV) * 0.5;
            titleInsets = UIEdgeInsets(top: topBottomH + titleSize.height + marginHV, left: (btnSize.width - titleSize.width)/2.0 - imgSize.width, bottom: topBottomH, right: (btnSize.width - titleSize.width)/2.0)
        
            imgInsets = UIEdgeInsets(top: topBottomH, left: (btnSize.width - imgSize.width)/2.0, bottom: marginHV + topBottomH + titleSize.height, right: (btnSize.width - imgSize.width)/2.0 - titleSize.width)
        default:
            break
        }
        
        titleEdgeInsets = titleInsets;
        imageEdgeInsets = imgInsets;
    }

}
