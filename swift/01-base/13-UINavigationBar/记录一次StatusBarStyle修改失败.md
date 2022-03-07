/*
之前一个项目中，VC的层级关系是：
    UIViewController
        -- child -> UITabBarController
            -- UINavigationController1
                -- UIViewController
            -- UINavigationController2
                -- UIViewController
            -- UINavigationController3
                -- UIViewController

场景是需要在不同的VC中修改指定状态栏不同的样式，结果我尝试了
https://www.logcg.com/archives/3343.html
https://segmentfault.com/a/1190000023390550
 博客中所有的方法都无效。
 
最后看系统API，如下几个方法我们通常会这样重写。我们可以知道 status bar style 的样式是一层一层VC来决定的。

那么对于上面项目中 VC 的层级结构我们可以看出，需要做一些特殊的处理。具体操作请看代码二。

*/


```Swift
class KDHBDBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
        当系统需要视图控制器来确定状态栏样式时调用。该属性返回 VC 的 status bar style 将被使用。
        如果容器VC想使用其子VC的 status bar style，请使用该方法返回 其子VC。
        如果不重写此方法，或者返回nil，则使用当前VC的style。
        如果此方法返回的值更改，请调用 setNeedsStatusBarAppearanceUpdate
    */
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    /*
        返回 VC 首选的 status bar style。
    */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    // 是否隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}
```


```Swift
class KDMainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.children.last
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.children.last?.preferredStatusBarStyle ?? .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}

class KDMainTabBarViewController: UITabBarController {
    override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

// 然后在子VC中重写 preferredStatusBarStyle 即可
```

