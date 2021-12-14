import Foundation

// MARK: - 字符串 size 计算
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

// MARK: - 图片 url 中文处理
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
    
    /// 中文字符串百分号转码
    func urlEncoded()-> String {
        let result = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return result ?? ""
    }
    
    /// 中文字符串百分号解码
    func urlDecode()-> String {
        self.removingPercentEncoding ?? ""
    }
}

// MARK: - 字符串过滤
extension String {
    
    /// 去掉字符串首尾空格 + 换行
    var trimHeadEndSpaceLine: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// 去掉字符串首尾空格
    var trimHeadEndTailSpace: String {
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
    
    /// 把字符串中某一组字符串用某个字符串替换
    func replace(segs: String..., with replacement: String) -> String {
        var result: String = self
        for seg in segs {
            guard result.contains(seg) else { continue }
            result = result.replacingOccurrences(of: seg, with: replacement)
        }
        return result
    }

    /// 提取字符串中的数字拼接成一个新的字符串
    func extractDigits() -> String {
        guard !self.isEmpty else { return "" }
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

// MARK: - 人民币单位转换

extension String {
    
    // 把单位为分 转化为 单位为元，并且保留小数点后2位 的字符串
    func fenToRMB() -> Self {
        var str = self
        // 先去掉负数
        var isNegativeNum = false
        if str.hasPrefix("-") {
            str = (str as NSString).substring(from: 1)
            isNegativeNum = true
        }
        // 去掉以0开头
        while str.hasPrefix("0") == true {
            str = (str as NSString).substring(from: 1)
        }
        // 添加.
        if str.count < 3 {
            str = String(repeating: "0", count: 3 - str.count) + str
        }
        str.insert(".", at: str.index(str.endIndex, offsetBy: -2))
        return isNegativeNum ? "-\(str)" : str
    }
    
    // 把单位为分 转化为 单位为元，并且去掉小数点后多余0 的字符串
    func fenToRMBEndNoZero() -> Self {
        var str = self.fenToRMB()
        // 去掉以0结尾
        while str.hasSuffix("0") {
            str.remove(at: str.index(str.endIndex, offsetBy: -1))
        }
        // 去掉以.结尾
        if str.hasSuffix(".") {
            str.remove(at: str.index(str.endIndex, offsetBy: -1))
        }
        return str
    }
}

// MARK: - 字符串截取
extension String {

    /// 截取第 index 处出现 separato 与下一次出现 separato 之间的字符串
    func segment(separatedBy separator: String, at index: Int = Int.max) -> String {
        guard self.contains(separator) else { return self }
        let segments = components(separatedBy: separator)
        let realIndex = min(index, segments.count - 1)
        return String(segments[realIndex])
    }

    /// 截取第一次出现某个字符后面的所有字符串
    func segment(from chtStr: Character) -> String {
        if var firstIndex = self.firstIndex(of: chtStr) {
            firstIndex = self.index(firstIndex, offsetBy: 1)
            let subString = self[firstIndex..<self.endIndex]
            return String(subString)
        }
        return self
    }

}
