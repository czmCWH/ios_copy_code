

// https://github.com/KennethTsang/GrowingTextView


textField.isEditable = false


let textView = UITextView()
textView.text = "填写后会被系统推荐"
textView.font = UIFont.systemFont(ofSize: 14)
textView.textColor = UIColor("#AEAEB2")
textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
textView.textContainer.maximumNumberOfLines = 3
textView.textContainer.lineBreakMode = .byTruncatingTail
textView.delegate = self
textView.clipsToBounds = true
textView.layer.cornerRadius = 8
textView.bounces = false
textView.isScrollEnabled = false
textView.backgroundColor = ColorBackgroundColor6



/// UITextView限制输入文本字符数，https://blog.csdn.net/qq_36487644/article/details/85252169
func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard
        let oldString = textView.text,
        let range = Range(range, in: oldString)
        else { return true }
    
    let newString = oldString.replacingCharacters(in: range, with: text)
    if oldString.count < limitWords {
        numLabel.text = "\(newString.count)"
    }
    return true
}

func textViewDidChange(_ textView: UITextView) {
    checkShowHiddenPlaceholder()
    // /获取高亮部分
    let selectedRange = textView.markedTextRange
    let pos = textView.position(from: textView.beginningOfDocument, offset: 0)
    
    /// 如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange != nil) && (pos != nil) {
        return
    }
    if textView.text.count >= limitWords {
        textView.text = String(textView.text.prefix(limitWords))
    }
    countLabel.text = "\(textView.text.count)/\(limitWords)"
    if textModel != nil {
        self.textModel?.value = textView.text
    }
}

