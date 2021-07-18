
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
textField.delegate = self;
self.addSubviewToFill(textField)

NotificationCenter.default.addObserver(self, selector: #selector(textFieldChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)


@objc private func textFieldChanged(_ notify: Notification) {
    self.updateLabelStatus()
    
    
}
