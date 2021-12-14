
import UIKit

extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
    }
    
    func opaqueNavigationBar() {
        self.shadowImage = nil
        self.setBackgroundImage(nil, for: .default)
    }
}
