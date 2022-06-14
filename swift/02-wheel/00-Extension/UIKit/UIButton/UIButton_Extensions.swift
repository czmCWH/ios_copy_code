import UIKit

// MARK:- convenience init

extension UIButton {
    
    /// 使用`font & textColor & font`创建一个`custom UIButton`
    convenience init(title: String? = nil, titleColor: UIColor, font: UIFont, bgColor: UIColor? = nil, _ cornerRadius: CGFloat? = nil) {
        self.init(type: .custom)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        
        if let bgColor = bgColor {
            self.backgroundColor = bgColor
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    /// 设置 `UIButton` 的外边框属性
    func setBtnBorder(borderWidth: CGFloat?, borderColor: UIColor?, cornerRadius: CGFloat?) {
        if let borderWidth = borderWidth, let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
}

// MARK:- 扩大UIButton点击范围

/* 使用方式：
 // 向四周扩展10
 btn.hitEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    
 */
extension UIButton {
    
    private struct AssociatedKeys {
        static var hitEdgetInsets = "zm_hitEdgetInsets"
        static var hitScale = "zm_hitScale"
        static var hitWidthScale = "zm_hitWidthScale"
        static var hitHeightScale = "zm_hitHeightScale"
    }
    
    /// 各个边界扩张的范围：UIEdgeInsets(top: , left: , bottom: , right: )
    var hitEdgeInsets:UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitEdgetInsets) as? UIEdgeInsets
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.hitEdgetInsets,
                    newValue as UIEdgeInsets?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    /// 各个边界统一的扩张返回
    var hitScale:CGFloat? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitScale) as? CGFloat
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.hitScale,
                    newValue as CGFloat?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    /// 宽度扩张的范围
    var hitWidthScale:CGFloat? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitWidthScale) as? CGFloat
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.hitWidthScale,
                    newValue as CGFloat?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    /// 高度扩张的返回
    var hitHeightScale:CGFloat? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.hitHeightScale) as? CGFloat
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.hitHeightScale,
                    newValue as CGFloat?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
//    alignmentRectInsets
    open override var alignmentRectInsets: UIEdgeInsets {
        get {
            if self.hitEdgeInsets == UIEdgeInsets.zero {
                return self.alignmentRectInsets
            } else {
                return self.hitEdgeInsets ?? UIEdgeInsets.zero
            }
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        // 如果 button 边界值无变化  失效 隐藏 或者透明 直接返回
        if self.hitEdgeInsets == UIEdgeInsets.zero || !self.isEnabled || self.isHidden || self.alpha == 0 {
            return super.point(inside: point, with: event)
        } else {

            let relativeFrame = self.bounds
            let hitFrame = relativeFrame.inset(by: self.hitEdgeInsets ?? UIEdgeInsets.zero)
            return hitFrame.contains(point)
        }
    }
}
