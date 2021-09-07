
import UIKit

/// UITextField禁用 粘贴、复制、选择
class PressTextField: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }

}


