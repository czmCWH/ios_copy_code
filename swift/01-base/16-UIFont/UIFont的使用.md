# UIFont的使用

我们经常遇到时间倒计时，会有跳动，如下方法可解决数字切换导致宽度跳动的问题。

```
// 返回宽度一致的所有数字的标准系统字体
lab.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: .regular)
```


https://github.com/mokong/SwiftCommonExtension/blob/main/CommonSwiftExtension/Common/Extension/UIFont_Extensions.swift