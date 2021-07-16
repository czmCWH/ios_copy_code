//
//  PressTextView.swift
//  power-coolene
//
//  Created by dong on 2021/3/3.
//

import UIKit

/// UITextView 禁用 粘贴、复制、选择
class PressTextView: UITextView {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }

}
