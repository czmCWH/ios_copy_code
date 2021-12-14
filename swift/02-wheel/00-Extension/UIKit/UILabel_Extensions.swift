
import UIKit

extension UILabel {
    
    // 快速创建一个`UILabel`，使用`font & textColor | alignment`
    convenience public init(font: UIFont?, color: UIColor, alignment: NSTextAlignment = .left) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }
    
}
