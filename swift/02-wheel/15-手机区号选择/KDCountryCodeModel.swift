
import UIKit
import HandyJSON

class KDCountryCodeListModel: HandyJSON {

    var key: String = ""
    var countryList: [KDCountryCodeModel] = []
    
    func mapping(mapper: HelpingMapper) {
            mapper <<<
                self.countryList <-- "data"
    }

    required init() { }
}

/// 国家地区模型
class KDCountryCodeModel: HandyJSON {
    
    /// 地区名称
    var countryName: String = ""
    /// 地区名称拼音
    var countryPinyin: String = ""
    /// 地区电话区号
    var phoneCode: String = ""
    /// 地区编码
    var countryCode: String = ""
    
    required init() { }
}
