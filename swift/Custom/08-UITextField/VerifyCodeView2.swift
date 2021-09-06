//
//  VerifyCodeView.swift
//  test01
//
//  Created by czm on 2021/9/3.
//
/* 使用方式：
 
 let inputView = VerifyCodeView()
 self.view.addSubview(inputView)
 inputView.snp.makeConstraints {
     $0.centerX.equalToSuperview()
     $0.top.equalTo(200)
     $0.size.equalTo(CGSize(width: 265, height: 35))
 }
 */

import UIKit

/// 单个方框格、并且带光标验证码输入框
class VerifyCodeView: UIView, UITextFieldDelegate {
    
    private var stackView: UIStackView!
    private var textField: UITextField!
    private var maskButton: UIButton!

    /// 验证码长度
    private var length: NSInteger = 6
    private let selColor = UIColor.black
    private let norColor = UIColor.gray
    private var currentLabel: CursorLabel?
    
    /// 输入完成
    var inputCompletionHandler: ((String) -> ())?
    

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
        stackView.spacing = 12
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
        
        maskButton = UIButton(type: .custom)
        maskButton.addTarget(self, action: #selector(clickActionButton(_:)), for: .touchUpInside)
        self.addSubviewToFill(maskButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldChanged(_:)), name: UITextField.textDidChangeNotification, object: textField)
        
        for _ in 0..<6 {
            let label = CursorLabel()
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.textColor = UIColor(0x141414)
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
            let lab = stackView.arrangedSubviews[idx] as! CursorLabel
            
            if textArray.count != 0 && idx < textArray.count {
                lab.text = textArray[idx]
            } else {
                lab.text = nil
            }
            
            if idx == textArray.count {
                lab.layer.borderColor = self.selColor.cgColor
                self.currentLabel = lab
                lab.startAnimating()
            } else {
                lab.layer.borderColor = self.norColor.cgColor
                lab.stopAnimating()
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
    
    /// 点击遮挡按钮，让 UITextField 成为第一响应者
    @objc private func clickActionButton(_ btn: UIButton) {
        self.becomeResponder()
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
                (lab as? CursorLabel)?.layer.borderColor = self.selColor.cgColor
            }
            
            self.inputCompletionHandler?(textField.text ?? "")
        } else {
            for lab in stackView.arrangedSubviews {
                (lab as? CursorLabel)?.layer.borderColor = self.norColor.cgColor
                
            }
        }
        self.currentLabel?.stopAnimating()
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

///// UITextField禁用 粘贴、复制、选择
//class NoPressTextField: UITextField {
//
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        UIMenuController.shared.isMenuVisible = false
//        return false
//    }
//
//}

/// 带光标的 View
class CursorLabel: UILabel {
    
    /// 光标view
    lazy var cursorView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.alpha = 0.0
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.addSubview(cursorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        
        self.cursorView.frame = CGRect(x: (w - 2)*0.5, y: h * 0.1, width: 2, height: h * 0.8)
    }
    
    func startAnimating() {
        if (self.text?.count ?? 0) > 0 { return }
        
        let animate = CABasicAnimation(keyPath: "opacity")
        animate.fromValue = 0
        animate.toValue = 1
        animate.duration = 1
        animate.repeatCount = MAXFLOAT
        animate.isRemovedOnCompletion = false
        animate.fillMode = .forwards
        animate.timingFunction = CAMediaTimingFunction(name: .easeIn)
        self.cursorView.layer.add(animate, forKey: "key_opacity")
    }
    
    func stopAnimating() {
        self.cursorView.layer.removeAnimation(forKey: "key_opacity")
    }
}
