
import UIKit


extension UIImage {
    
    /// 获取原始图片，避免系统自动渲染
    var original: Self? {
        self.withRenderingMode(.alwaysOriginal) as? Self
    }
    
    /// 根据颜色创建图片
    class func imageWithColor(_ color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

