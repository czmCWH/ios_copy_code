
/**
 打印所有字体：
 for family in UIFont.familyNames.sorted() {
     let names = UIFont.fontNames(forFamilyName: family)
     print("Family: \(family) Font names: \(names)")
 }
 
 */

import UIKit

extension UIFont{
    
    // PingFangSC 类型的字体与 systemFont 方式类似
    
    class func zm_pf_regular(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func zm_pf_semibold(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func zm_pf_medium(size:CGFloat)->UIFont{
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // arial 类型的字体以 斜体的方式 显示英文，类似于 italicSystemFont
    
    class func zm_arial(size:CGFloat)->UIFont{
        return UIFont(name: "Arial-ItalicMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    class func zm_arial_blod(size:CGFloat)->UIFont{
        return UIFont(name: "Arial-BoldItalicMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // DIN Condensed 用于设置数字
    class func zm_DINCondensed(size:CGFloat)->UIFont{
        return UIFont(name: "DINCondensed-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // DIN Alternate 用于设置英文标识
    class func zm_DINAlternate(size:CGFloat)->UIFont{
        return UIFont(name: "DINAlternate-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    class func zm_ZapfDingbats(size: CGFloat) -> UIFont {
        return UIFont(name: "Zapf Dingbats", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

