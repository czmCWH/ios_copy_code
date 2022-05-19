lengthyLabel = MarqueeLabel(frame: CGRect(x: 20, y: 500, width: self.view.frame.size.width - 40, height: 20))
lengthyLabel.text = "好好学习天天向上"
lengthyLabel.font = UIFont.systemFont(ofSize: 13)
lengthyLabel.textColor = UIColor.red
// 无论文本字符串长度如何，都保持滚动
lengthyLabel.forceScrolling = true
// 连续向左滚动
lengthyLabel.type = .continuous
// 每次滚动一条，在原始位置暂停的时间
lengthyLabel.animationDelay = 0
// 设置滚动动画的速率或者持续时间，如下设置其 50 pt/s
lengthyLabel.speed = .rate(50.0)
// 用作两个标签之间的间距
lengthyLabel.leadingBuffer = 10.0

self.view.addSubview(lengthyLabel)