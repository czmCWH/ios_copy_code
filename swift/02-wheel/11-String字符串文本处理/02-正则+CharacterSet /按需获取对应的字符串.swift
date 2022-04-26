

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


// MARK: - 字符串去掉emoji，暂用

// https://www.jianshu.com/p/c63b043cb9bd，尽量采用此方式

// https://www.hangge.com/blog/cache/detail_1647.html

/*
 
 let str1: String = "欢迎🆚访问💓😄hangg👨‍👧‍👧♠️🐈‍⬛e.com🗯🕍"
 //判断表情的正则表达式
 let pattern = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]"
 //替换后的字符串
 let str2 = str1.pregReplace(pattern: pattern, with: "")
 
 */

extension String {
    //返回字数
    var ex_count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
     
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.ex_count),
                                              withTemplate: with)
    }
}
