// 时间计算

// MARK: - 计算App进入后台切换到前台停留的时间

/*
 可以使用如下三种方式记录时间：
 
 1、Date()
 2、CFAbsoluteTimeGetCurrent() 相当于 Date().timeIntervalSinceReferenceDate
    1和2 返回的时钟时间将会会网络时间同步，从时钟 偏移量的角度，
    
 
 3、CACurrentMediaTime()
    是基于内建时钟的，能够更精确更原子化地测量，并且不会因为外部时间变化而变化（例如时区变化、夏时制、秒突变等）,但它和系统的uptime有关,系统重启后CACurrentMediaTime()会被重置。
 
 如果App退到后台，修改系统时间，那么 1和2 返回的时间会以修改的时间一样。而 3 会返回真实的时间。
 
 */


do {
    
    var startTime = CACurrentMediaTime()
    
    func init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func caculateSecond() {
        
        let endTime = CACurrentMediaTime()
        let seconds = Int(endTime - startTime)

        print("====czm===", timerStr(timerStr))
    }
    
    
    @objc private func appDidEnterBackground() {
        print("===== App 回到后台")
    }
    
    @objc private func appWillEnterForeground() {
        print("===== App 回到前台")
    }
    
    /// 把秒转换为天时分秒
    private func timerStr(_ totalSeconds: Int) -> String {
        if totalSeconds <= 0 {
            return "00:00:00"
        }
        let days = totalSeconds/(24*3600)
        let hours = (totalSeconds / 3600) % 24
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60
        
        if days != 0 {
            return String(format: "%d天%02d:%02d:%02d", days, hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
}


