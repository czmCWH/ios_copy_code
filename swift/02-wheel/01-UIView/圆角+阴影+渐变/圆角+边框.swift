
// MARK: - 通过两个 layer 的方式设置 圆角和边框。

do {
    let cornerView = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
    cornerView.backgroundColor = .red
    self.view.addSubview(cornerView)
    
    // 设置部分圆角
    let path = UIBezierPath(roundedRect: cornerView.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 50, height: 50))
    let shapeLayer = (cornerView.layer.mask as? CAShapeLayer) ?? CAShapeLayer()
    shapeLayer.path = path.cgPath
    cornerView.layer.mask = shapeLayer
    
    // 设置边框
    let subLayer = CAShapeLayer()
    subLayer.fillColor = UIColor.clear.cgColor
    subLayer.strokeColor = UIColor.blue.cgColor
    subLayer.lineWidth = 5*2;
    subLayer.path = (cornerView.layer.mask as? CAShapeLayer)?.path
    cornerView.layer.addSublayer(subLayer)
}



extension UIView {
    
    func clipCorners(roundedRect: CGRect?, corners: UIRectCorner, cornerRadii: CGSize) {
        let rect = roundedRect ?? self.bounds
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        
        let shapeLayer = (self.layer.mask as? CAShapeLayer) ?? CAShapeLayer()
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    
    
    
}
