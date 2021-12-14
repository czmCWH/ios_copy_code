
import UIKit

extension UIColor {
    
    convenience init(_ hex: Int, alpha: CGFloat = 1.0) {
        assert(
            0...0xFFFFFF ~= hex,
            "UIColor+Hex: Hex value given to UIColor initializer should only include RGB values, i.e. the hex value should have six digits." //swiftlint:disable:this line_length
        )
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: components.R, green: components.G, blue: components.B, alpha: alpha)
        } else {
            self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
        }
    }
}

