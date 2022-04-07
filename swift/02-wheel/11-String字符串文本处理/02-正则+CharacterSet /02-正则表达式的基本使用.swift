/// 正则表达式的基本使用


正则表达式（Swift）：https://www.cnblogs.com/zwvista/p/8324371.html

Swift 正则表达式完整教程：https://www.jianshu.com/p/c579d3692876

swift5.0判断字符串中是否含有emoji表情的那些坑：https://www.jianshu.com/p/17f5dfce472d


func test1() {
    guard let validate = textView.text else { return }
    
    let regex = "[\\u4e00-\\u9fa50-9a-zA-Z]"
//        let regex = "[\\p{Script=Han}0-9a-zA-Z]"
    
//        let regex = "\\p{Script=Han}"
//        let regex = "[\\u4e00-\\u9fa5]"
   

    let RE = try? NSRegularExpression(pattern: regex, options: .caseInsensitive)
    guard let matchs = RE?.matches(in: validate, options: [], range: NSRange(validate.startIndex..., in: validate)) else { return }

    
    var data:[String] = Array()
    for item in matchs {
        let string = (validate as NSString).substring(with: item.range)
        data.append(string)
    }
    
    print("===czm====", data)
    
    
    //        let str = validate.trimmingCharacters(in: chSet)
            
    //        let str = (validate.components(separatedBy: chSet) as NSArray).componentsJoined(by: "")
}
