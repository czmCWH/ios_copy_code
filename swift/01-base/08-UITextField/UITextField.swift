
textField = UITextField()
textField.borderStyle = .none
textField.backgroundColor = .clear
textField.keyboardType = .numberPad
// 禁用首字母大写
textField.autocapitalizationType = .none
// 禁用自动联想功能
textField.autocorrectionType = .no
// 清除光标颜色
textField.tintColor = .clear
// 清除文字颜色
textField.textColor = .clear
textField.attributedPlaceholder = NSAttributedString(string: "搜索框占位文字", attributes: [.font: UIFont.zm_pf_regular(size: 12), .foregroundColor: UIColor(0xC2C4C9)])

// 设置左侧占位View
textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 30))
textField.leftViewMode = .always

textField.returnKeyType = .search
textField.enablesReturnKeyAutomatically = true

textField.clearButtonMode = .whileEditing

textField.delegate = self;
self.addSubviewToFill(textField)

NotificationCenter.default.addObserver(self, selector: #selector(textFieldChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)


@objc private func textFieldChanged(_ notify: Notification) {
    self.updateLabelStatus()
    
    
}

// MARK:- UITextField一些可被重写的方法

{
    
    – textRectForBounds:　 //重写来重置文字区域
    – drawTextInRect: 　　 //改变绘文字属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了.
    – placeholderRectForBounds:　　//重写来重置占位符区域
    – drawPlaceholderInRect:　　//重写改变绘制占位符属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了
    – borderRectForBounds:　　//重写来重置边缘区域
    – editingRectForBounds:　　//重写来重置编辑区域
    – clearButtonRectForBounds:　　//重写来重置clearButton位置,改变size可能导致button的图片失真
    – leftViewRectForBounds:
    – rightViewRectForBounds:
    ————————————————
    版权声明：本文为CSDN博主「H.A.N」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
    原文链接：https://blog.csdn.net/u010960265/article/details/82905395
    
}



// MARK:- UITextFieldDelegate

// 强制UITextField只能输入大写字母
// https://15tar.com/ios/2015/04/10/force-uitextfield-input-text-to-upper-case.html
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var lowercaseCharRange: NSRange
    lowercaseCharRange = (string as NSString).rangeOfCharacter(from: CharacterSet.lowercaseLetters)

    if lowercaseCharRange.location != NSNotFound {

        textField.text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string.uppercased())
        return false
    }

    return true
}
