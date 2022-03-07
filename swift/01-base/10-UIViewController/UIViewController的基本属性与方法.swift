class TwoViewController: UIViewController {
    
    override func loadView() {
//        super.loadView()
        
        self.view = SubView(viewMoel: viewModel)
        
        // do ...
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// 视图即将可见时调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /// 视图已完全过渡到屏幕上时调用
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
    // iPhone下每个app可用的内存是被限制的，如果一个app使用的内存超过20M，则系统会向该app发送Memory Warning消息。
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // https://segmentfault.com/a/1190000016350198
    }

    // 隐藏iphone x底部黑条
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

}
