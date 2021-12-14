
import Foundation

extension Bundle {
    
    /// 读取某个文件路径
    func readPath(name: String?, type: String?) -> String? {
        return Bundle.main.path(forResource: name, ofType: type)
    }
    
    /// 读取某个文件的url
    func readPathUrl(name: String?, type: String?) -> URL?  {
        return Bundle.main.url(forResource: name, withExtension: type)
    }
}
