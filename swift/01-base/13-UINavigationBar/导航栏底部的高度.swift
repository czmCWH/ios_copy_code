
// 导航栏高度
let navigationBarH = UIApplication.shared.statusBarFrame.height + 44


// 隐藏Home Indicator (Home键指示器)
- (BOOL)prefersHomeIndicatorAutoHidden {
  return YES;
}

// 底部安全区域的高度
let safeAreaBottomH: CGFloat
if #available(iOS 11.0, *) {
    safeAreaBottomH = self.view.safeAreaInsets.bottom
//            UIApplication.shared.windows.last?.safeAreaInsets.bottom
} else {
    safeAreaBottomH = 0
}
