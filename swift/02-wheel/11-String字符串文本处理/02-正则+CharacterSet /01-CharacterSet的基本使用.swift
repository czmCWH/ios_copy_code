/// CharacterSet的基本使用



CharacterSet的使用：
https://blog.csdn.net/xiaobo0134/article/details/111885612
https://www.jianshu.com/p/f6baf8b55557/
https://www.jianshu.com/p/75cb42e4593c
https://www.jianshu.com/p/572dd7659012


NSCharacterSet字符集：
https://www.jianshu.com/p/75cb42e4593c


func test1(_ validate: String) {
    var chSet = CharacterSet()
    chSet.formUnion(.whitespacesAndNewlines)        // 空格和换行
    chSet.formUnion(.punctuationCharacters)     // 标点符号，连接线
    chSet.formUnion(.controlCharacters)     // 控制符的字符集
    chSet.formUnion(.illegalCharacters)     // 不合规字符，没有在Unicode 3.2 标准中定义的字符
//        chSet.formUnion(.symbols)     //    符号的字符集
    chSet.formUnion(.nonBaseCharacters)     // 非基础的字符集
    let otherSyb = CharacterSet(charactersIn: "@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"")
    chSet.formUnion(otherSyb)     //    //
    
//        let str = validate.trimmingCharacters(in: chSet as CharacterSet)
    
//        let str1 = (validate.components(separatedBy: chSet) as NSArray).componentsJoined(by: "")
    
    let str1 = validate.components(separatedBy: .symbols).joined()
}
