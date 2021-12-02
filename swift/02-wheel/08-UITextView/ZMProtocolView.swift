//
//  ZMProtocolView.swift
//  test01
//
//  Created by czm on 2021/9/6.
//
/* 使用方式：
 let protocolV = ZMProtocolView()
 protocolV.clickAction = { [weak self] (idx) in
     print("===czm===", idx)
 }
 self.view.addSubview(protocolV)
 protocolV.snp.makeConstraints {
     $0.centerX.equalToSuperview()
     $0.top.equalTo(200)
 }
 */

import UIKit

/// 用户协议控件
class ZMProtocolView: UIView, UITextViewDelegate {
    
    /// 勾选协议按钮的size
    var checkBtnSize = CGSize(width: 30, height: 30)
    /// 整个组件左右边距
    var horizontalMargin: CGFloat = 15
    
    var textStr = "我已阅读并同意我已阅读并同意我已阅读并同意《用户服务协议》和《隐私政策》"
    var protocolArray: [String] = ["《用户服务协议》", "《隐私政策》"]
    var actionTagStr = "protocol"
    
    var textFont = UIFont.systemFont(ofSize: 12)
    var textColor = UIColor.black
    var protocolColor = UIColor.red
    
    /// 协议内容富文本
     var attriStr: NSMutableAttributedString {
        
        let norAttri: [NSAttributedString.Key : Any] = [.foregroundColor: textColor, .font: textFont]
        let attriStr = NSMutableAttributedString(string: textStr, attributes: norAttri)
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineSpacing = 3   // 行间距
        attriStr.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attriStr.length))
        
        for (idx, item) in protocolArray.enumerated() {
            let itemRange = (textStr as NSString).range(of: item)
            let selAttri: [NSAttributedString.Key : Any] = [.link: "\(actionTagStr)\(idx)://", .font: textFont, .foregroundColor: protocolColor]
            attriStr.addAttributes(selAttri, range: itemRange)
            
        }
        return attriStr
    }
    
    /// 协议文本的 size，根据 attriStr 计算而来
    var textSize: CGSize {
        let strMaxW = UIScreen.main.bounds.size.width - horizontalMargin*2 - checkBtnSize.width
        let maxSize = CGSize(width: strMaxW, height: CGFloat.greatestFiniteMagnitude)
        let caculateSize = self.attriStr.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        let strRealW: CGFloat = CGFloat(ceilf(Float(caculateSize.width)))
        let strRealH: CGFloat = CGFloat(ceilf(Float(caculateSize.height)))
        return CGSize(width: strRealW, height: strRealH)
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var checkButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .green
        btn.contentHorizontalAlignment = .left
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.setImage(UIImage(named: ""), for: .selected)
        return btn
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        // 去掉左右边距
        textView.textContainer.lineFragmentPadding = 0
        // 去掉上下边距
        textView.textContainerInset = .zero
        textView.backgroundColor = .yellow
        textView.delegate = self
        textView.isScrollEnabled = false
        // 消除超链接原有的字体颜色，此处如不设置，设置的att1颜色可能不会生效
        textView.linkTextAttributes = [:]
        // 此处必须设置为true，否则点击事件会不生效
        textView.isSelectable = true
        // 必须禁止输入，否则点击将会弹出输入键盘
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        return textView
    }()
    
    /// 点击协议的回调：从左到右，索引从0开始
    var clickAction: ((Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.size.equalTo(checkBtnSize)
        }
        
        self.textView.attributedText = self.attriStr
        self.stackView.addArrangedSubview(textView)
        textView.snp.makeConstraints {
            $0.size.equalTo(self.textSize)
        }
    }
    
    /// 响应点击协议的事件
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        if let urlStr = URL.scheme, urlStr.hasPrefix(actionTagStr) {
            let idx1 = urlStr.index(urlStr.startIndex, offsetBy: actionTagStr.count)
            let tag = Int(String(urlStr[idx1...])) ?? 0
            
//            print("protocol点击事件", tag)
            self.clickAction?(tag)
            
            return false
        }
        
        return true
    }
    
    // textView.isEditable = true 和 该方法返回 false 来禁用弹出复制粘贴选择文本
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }

}
