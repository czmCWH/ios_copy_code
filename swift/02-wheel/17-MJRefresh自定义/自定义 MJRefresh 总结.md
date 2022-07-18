# 自定义 MJRefresh 总结


## 如何动态修改 MJRefreshFooter 的高度

通过 `tableView.mj_footer?.mj_h = 30` 在某个时刻修改高度时不会生效，而且会导致 `tableView` 的 `contentSize` 滚动范围计算不准确最后一个 `Cell` 被挡住一半。

通过 [MJRefresh 源码学习笔记](https://juejin.cn/post/7004291891063701540#heading-16) 博客上，修改高度时需要先隐藏在现实。

```
最后是 setHidden: 方法，根据显示隐藏的变化，调整 contentInset 、 state 和 self.frame.origin.y。


- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    // 从显示变成隐藏状态
    if (!lastHidden && hidden) {
        
        self.state = MJRefreshStateIdle;
        self.scrollView.mj_insetB -= self.mj_h;
        
    } else if (lastHidden && !hidden) {
        
        // 从隐藏变成显示状态
        
        self.scrollView.mj_insetB += self.mj_h;
        // 设置位置
        self.mj_y = _scrollView.mj_contentH;
    }
}
```

动态修改 `MJRefresh`的方式，即：

```
1、tableView.mj_footer?.isHidden = true
2、tableView.mj_footer?.mj_h = newHeight
3、tableView.mj_footer?.isHidden = false
```


## tableView.mj_header?.endRefreshing() 不会立马结束刷新，因为有动画的存在


## 参考博客

Boss直聘下拉刷新效果的实现：https://github.com/gitKun/-Boss-