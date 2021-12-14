
import Foundation

extension URL {
    
    /// 获取URL后面拼接的参数
    func params() -> [String : String] {
        var dict = [String : String]()

        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value!
                }
            }
            return dict
        } else {
            return [ : ]
        }
    }
}
