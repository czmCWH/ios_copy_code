extension Collection {
    
    /// 访问数组下标的值，避免越界抛异常
    /// eg:  let arr = [1, 3,  4]  arr[safe: 3]
    /// https://github.com/Luur/SwiftTips
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    
}
