
import UIKit

// MARK:- 获取设置坐标属性
extension UIView {
    var x: CGFloat {
        get { frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    var y: CGFloat {
        get { frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    var width: CGFloat {
        get { frame.size.width }
        set { frame.size.width = newValue }
    }
    
    var height: CGFloat {
        get { frame.size.height }
        set { frame.size.height = newValue }
    }
    
    var top: CGFloat {
        get { y }
        set { y = newValue }
    }
    
    var bottom: CGFloat {
        get { y + height }
        set { y = newValue - height }
    }
}

// MARK:- 便利方法
extension UIView {
    
    /// 设置背景颜色初始化方法
    convenience init(bgColor: UIColor?) {
        self.init()
        backgroundColor = bgColor
    }
    
    /// 同时添加多个子控件
    /// https://github.com/DarielChen/iOSTips
    /// - Parameter subviews: 单个或多个子控件
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }

    ///移除所有的子View
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// SwifterSwift：获取当前View的截图
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// SwifterSwift：获取View所在的VC
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
