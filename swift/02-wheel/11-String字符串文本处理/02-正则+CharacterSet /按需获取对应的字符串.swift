

import Foundation

/// 计算中文、英文字母、数字、表情的总数
func gainZhEnNumEmojiCount(_ text: String?) -> Int {
    guard let text = text else {
        return 0
    }
    
    /// 正则计算中文、字母和数字的总数
    let regex = "[\\p{Script=Han}0-9a-zA-Z]"
    let RE = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
    let zhNumCount = RE?.matches(in: text, options: .reportProgress, range: NSRange(text.startIndex..., in: text)).count ?? 0

    // 计算emoji表情个数
    let noEmojiStr = text.components(separatedBy: .symbols).joined()
    let emojiCount = text.count - noEmojiStr.count
    
    // 总有效字符个数
    return zhNumCount + emojiCount
}
