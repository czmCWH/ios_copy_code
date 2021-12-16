
/* 验证码输入框
 
 http://www.0daybug.com/posts/e9d3da40/index.html
 
 let inputView = ZMVerifyCodeInputView()
 inputView.inputCompletionHandler = { inputText in
     print("===czm===", inputText)
 }
 self.view.addSubview(inputView)
 
 inputView.snp.makeConstraints {
     $0.center.equalToSuperview()
     $0.size.equalTo(CGSize(width: 300, height: 50))
 }
 
 其它：https://github.com/JoanKing/JKVerifyCodeView
    
 https://github.com/josercc/ZHVerifyCodeField
 
 */

import UIKit

class ZMVerifyCodeInputView: UIView, UITextFieldDelegate{
    
    /// 验证码长度
    var length: NSInteger = 6
    /// 输入完成
    var inputCompletionHandler: ((String) -> ())?
    
    private var stackView: UIStackView!
    private var textField: UITextField!
    
    private let selColor = UIColor.black
    private let norColor = UIColor.gray

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        self.addSubviewToFill(stackView)
        
        textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.tintColor = .clear
        textField.textColor = .clear
        textField.delegate = self;
        self.addSubviewToFill(textField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)
        
        for _ in 0..<6 {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.textColor = UIColor.black
            label.layer.borderWidth = 1.0
            label.layer.borderColor = self.norColor.cgColor
            label.layer.cornerRadius = 5.0
            label.layer.masksToBounds = true
            stackView.addArrangedSubview(label)
        }
    }
    
    private func updateLabelStatus() {
        let textArray = (textField.text ?? "").map{ String($0) }
        for idx in 0..<self.length {
            let lab = stackView.arrangedSubviews[idx] as! UILabel
            
            if textArray.count != 0 && idx < textArray.count {
                lab.text = textArray[idx]
            } else {
                lab.text = nil
            }
            
            if idx == textArray.count {
                lab.layer.borderColor = self.selColor.cgColor
            } else {
                lab.layer.borderColor = self.norColor.cgColor
            }
        }
    }
    
    private func addSubviewToFill(_ subView: UIView) {
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 清除输入框
    func clearCode() {
        self.textField.text = nil
        for idx in 0..<self.length {
            let lab = stackView.arrangedSubviews[idx] as! UILabel
            lab.text = nil
            lab.layer.borderColor = self.norColor.cgColor
        }
    }
    
    /// 成为响应者
    func becomeResponder() {
        self.textField.becomeFirstResponder()
    }
    
    @objc private func textFieldChanged(_ notify: Notification) {
        self.updateLabelStatus()
        
        if textField.isEditing && textField.text?.count == self.length {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateLabelStatus()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if textField.text?.count == self.length {
            
            for lab in stackView.arrangedSubviews {
                (lab as? UILabel)?.layer.borderColor = self.selColor.cgColor
            }
            
            self.inputCompletionHandler?(textField.text ?? "")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 {
            if textField.text?.count == self.length {
                return false
            } else {
                return true
            }
        }
        return true
    }
}


