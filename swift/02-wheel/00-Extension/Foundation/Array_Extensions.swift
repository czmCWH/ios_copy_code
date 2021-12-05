import Foundation


extension Array where Element: Equatable {
    
    /// 移除数组中第一次出现的元素
    /// [1, 2, 3, 3, 5]    remove(3)    [1, 2, 3, 5]
    mutating func remove(_ object: Element) {
        if let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}


extension Array where Element: Hashable {
    
    /// 获取数组中某个元素后面的一个元素
    /// - Parameter item: 当前元素
    /// - Returns: 返回当前元素坐标加1的元素
    func after(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }
}


extension Array {
    
    /// 把数组按照元素个数分组
    /// - Parameter chunkSize: 每组个数
    /// - Returns: 返回分组后的数组
    func chunk(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map({ (startIndex) -> [Element] in
            let endIndex = (startIndex.advanced(by: chunkSize) > self.count) ? self.count-startIndex : chunkSize
            return Array(self[startIndex..<startIndex.advanced(by: endIndex)])
        })
    }
}
