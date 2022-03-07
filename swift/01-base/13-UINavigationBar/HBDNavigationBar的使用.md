
之前项目中使用了 https://github.com/listenzz/HBDNavigationBar 库来解决导航栏的一些问题，下面我就它的一些属性做个记录


1、设置导航栏白色，带有下划线，状态栏黑色。其实默认的 HBDNavigationController 就是这个样式

```
override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "首页"
    self.hbd_barTintColor =  UIColor.red
    self.hbd_barStyle = .default
    self.hbd_barShadowHidden = false
    
    self.view.backgroundColor = .white
    
    
}
```

2、设置导航栏透明，隐藏下划线，状态栏白色。

```
override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "第一个"
    self.hbd_barTintColor =  UIColor.clear
    self.hbd_barAlpha = 0.0
    self.hbd_barStyle = .black
    
    self.view.backgroundColor = .red
}
```
