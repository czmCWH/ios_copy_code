import Foundation

// MARK:- 字符串 size 计算
extension String {
    
    /// 计算文本的最大高度
    /// - Parameters:
    ///   - font: 字体大小
    ///   - fixedWidth: 固定宽度
    /// - Returns: 最大高度
    func sizeTextHeight(font: UIFont, fixedWidth: CGFloat) -> CGFloat {
        guard self.count > 0 && fixedWidth > 0 else {
            return 0
        }
        return sizeText(font: font, size: CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    /// 计算文本一行最大宽度
    func sizeTextWidth(font: UIFont) -> CGFloat {
        guard self.count > 0 else { return 0 }
        return sizeText(font: font, size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0)).width
    }
    
    /// 计算文本显示的size
    /// - Parameters:
    ///   - font: 文本显示字体大小
    ///   - size: 可显示的最大范围  CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    /// - Returns: 实际显示的范围
    func sizeText(font: UIFont, size: CGSize) -> CGRect {
        return (self as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    }
    
    /**
     * 查询lable高度
     * @param fontSize, 字体大小
     * @param width, lable宽度
     */
    func getLableHeightByWidth(_ fontSize: CGFloat,
                               width: CGFloat,
                               font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    /// 获取下标对应的字符
    func charAt(pos: Int) -> Character? {
        if pos < 0 || pos >= count {
            return nil   //判断边界条件
        }
        let index = self.index(self.startIndex, offsetBy: pos)
        let str = self[index]
        return Character(String(str))
    }
}

// MARK:- 图片 url 中文处理
extension String {
    /// 判断字符串是否包含中文、空格
    /// - Returns: true：有中文、空格
    func includeChinese() -> Bool {
        if self.contains(" ") { return true }
        for chart in self {
            let str = String(chart)
            if ("\u{4E00}" <= str  && str <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// 中文url百分号转码
    func percentEncoding() -> String {
        if self.includeChinese() {
            let str = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            return str
        } else {
            return self
        }
    }
}

// MARK:- 字符串过滤
extension String {
    
    /// 去掉字符串首尾空格 + 换行
    var trimmingHeadTailSpaceLine: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// 去掉字符串首尾空格
    var trimmingHeadTailSpace: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /// 去掉字符串中所有空格
    var removeAllSpace: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    /// 把由逗号、空格等隔开的字符串，转换为单词数组
    var words: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespaces)
            .filter{!$0.isEmpty}
    }
}
