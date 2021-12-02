//
//  CopyLabel.swift
//  test01
//
//  Created by czm on 2021/9/6.
//

import UIKit

/// 长按 Label 显示复制气泡按钮，进行复制操作。使用方式和 UILabel一致
class CopyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCopyConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCopyConfig()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setupCopyConfig() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(pressAction(_:))))
    }
    
    @objc private func pressAction(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            self.becomeFirstResponder()
            let menu = UIMenuController()
            menu.setTargetRect(self.bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) && self.text != nil {
            return true     // 允许copy
        }
        return false
    }
    
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
}
