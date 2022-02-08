/*
 
 QiShare 团队
 https://www.jianshu.com/p/fb8848f10430，https://github.com/QiShare/QiViewCornerCliper
 
 */

// MARK: - 以系统的方式圆角和阴影共存，缺陷是当存在子View时圆角有问题
do {
    
    let cornerView = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
    cornerView.backgroundColor = .red
    cornerView.layer.cornerRadius = 15
    
    cornerView.layer.shadowColor = UIColor.yellow.cgColor
    // 阴影的不透明度
    cornerView.layer.shadowOpacity = 1
    // 阴影的偏移量
    cornerView.layer.shadowOffset = CGSize(width: 0, height: -3)
    // 阴影的模糊半径
    cornerView.layer.shadowRadius = 15
    // 阴影的形状
    cornerView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 100)).cgPath
    
    /*
      通过上面的方式可以保证圆角和阴影共存，但是如果存在子View超出边界则需要通过如下属性进行裁剪，这样会导致阴影属性将失效。
     // 将 子layer 剪裁到 layer 的边界以内，可用于动画。
     cornerView.layer.masksToBounds = true
     // 子view在超出父view的frame时被裁剪
     cornerView.clipsToBounds = true
     // 设置 layer 显示蒙版
     cornerView.layer.mask = shapeLayer
     */
    
}

// MARK: - 设置部分角为圆角，但无法设置阴影

do {
    let cornerView = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
    cornerView.backgroundColor = .red
    self.view.addSubview(cornerView)

    let path = UIBezierPath(roundedRect: cornerView.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 30))
    let shapeLayer = (cornerView.layer.mask as? CAShapeLayer) ?? CAShapeLayer()
    shapeLayer.path = path.cgPath
    cornerView.layer.mask = shapeLayer
}


// MARK: - 通过自定义View，圆角和阴影共存

class CornerView: UIView {
    
    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 12, height: 12))
        maskPath.close()
        
        UIColor.green.setFill()
        maskPath.fill()
        
        self.layer.cornerRadius = 6
        self.layer.shadowColor = UIColor.red.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: -6)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        //.......
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
