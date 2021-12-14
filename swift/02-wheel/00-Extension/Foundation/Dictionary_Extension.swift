
import UIKit

extension Dictionary {

    /// 合并2个字典
    mutating func merge(_ dict: [Key: Value]?){
        guard let dict = dict else {
            return
        }
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    
    
}


