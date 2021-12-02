// 参考：https://github.com/xiaopin/XPTextView

import UIKit

/// 带有占位符的 UITextView
class ZMPlaceTextView: UITextView {
    
    var placeholder: (String?, UIColor?, UIFont?) {
        didSet {
            self.placeholderLabel.text = placeholder.0
            self.placeholderLabel.textColor = placeholder.1
            self.placeholderLabel.font = placeholder.2
        }
    }

    private lazy var placeholderLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        lab.lineBreakMode = self.textContainer.lineBreakMode
        lab.textAlignment = .left
        lab.numberOfLines = 0
        return lab
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChanged(_:)), name: UITextView.textDidChangeNotification, object: self)
        self.insertSubview(self.placeholderLabel, at: 0)
    }
    
    @objc private func textDidChanged(_ notify: Notification) {
        guard let textObj = notify.object as? ZMPlaceTextView,
              textObj === self, (self.placeholderLabel.text?.count ?? 0) != 0 else { return }
        
        self.placeholderLabel.isHidden = self.hasText
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.placeholderLabel.isHidden && self.placeholderLabel.text?.count != 0 {
            updatePlaceholderFrame()
        }
    }
    
    private func updatePlaceholderFrame() {
        
        let placeholderLabX = textContainer.lineFragmentPadding + textContainerInset.left
        let placeholderLabY = textContainerInset.top
        let placeholderLabW = self.frame.size.width - placeholderLabX - textContainer.lineFragmentPadding - self.textContainerInset.right;
        var placeholderLabH = self.placeholderLabel.sizeThatFits(CGSize(width: placeholderLabW, height: 0)).height
        let maxH = self.frame.size.height - textContainerInset.top - textContainerInset.bottom
        if placeholderLabH > maxH {
            placeholderLabH = maxH
        }
        self.placeholderLabel.frame = CGRect(x: placeholderLabX, y: placeholderLabY, width: placeholderLabW, height: placeholderLabH)
    }

}
