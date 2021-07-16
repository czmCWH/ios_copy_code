
import UIKit

extension UIStackView {
    /// 便利化创建布局View
    /// - Parameters:
    ///   - axis: 排列轴方向
    ///   - alignment: 垂直于axis方向，子视图对齐方式
    ///   - distribution: 调整子视图在axis轴方向的大小
    ///   - spacing: 子视图之间的间距
    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, alignment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .fill, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        
    }
    
    /// 同时添加多个子控件
    /// - Parameter subviews: 单个或多个子控件
    func add(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview(_:))
    }
}
