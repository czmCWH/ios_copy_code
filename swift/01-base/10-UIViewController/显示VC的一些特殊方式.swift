
// MARK: - 方式一：func show(_ vc: UIViewController, sender: Any?)

do {
    @objc func clickBtn(_ btn: UIButton) {
        
        let vc = ChildViewController()
        
        // 在主上下文中显示 VC
        // 此方法将显示 VC 的需求 与在屏幕上实际显示该 VC 的过程解耦。使用此方法，被显示的 VC 不需要知道它是被嵌入 navigationVC 还是 ViewController，而是自动进行 push、present...
        self.show(vc, sender: "船速")
    }
    
    // 该方法返回响应操作的视图控制器
    // show(_ :, sender:) 的默认实现，是使用 targetViewController 返回的值来显示VC。如果返回nil，则模态显示
    override func targetViewController(forAction action: Selector, sender: Any?) -> UIViewController? {
//        return self.navigationController
        return nil
        
    }
}

// MARK: - 方式一：
