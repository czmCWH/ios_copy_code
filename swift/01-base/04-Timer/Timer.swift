

// MARK: - GCD的方式实现计时器

var timer: DispatchSourceTimer?
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let count = 15
    
    self.timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    self.timer?.schedule(wallDeadline: .now(), repeating: 1)
    
    let endTime = Date(timeIntervalSinceNow: TimeInterval(count))
    
    self.timer?.setEventHandler(handler: { [weak self] () in
        
        let interval = endTime.timeIntervalSinceNow
        if interval <= 0 {
            
            self?.timer?.cancel()
            
            DispatchQueue.main.async {
                print("====NSTimer end===")
            }
            
        } else {
            DispatchQueue.main.async {
                print("====NSTimer czm===", Int(interval))
            }
        }
    })
    self.timer?.resume()
}


// MARK: - Timer 的方式实现计时器

weak var countdownTimer: Timer?
var countDownNum = 61
var endTime: Date?

func addTimer() {
    
    let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    RunLoop.main.add(timer, forMode: .common)
    endTime = Date(timeIntervalSinceNow: TimeInterval(countDownNum))
    self.countdownTimer = timer
}

func removeTimer() {
    self.countdownTimer?.invalidate()
}

@objc func timerUpdate() {
    let interval = endTime?.timeIntervalSinceNow
    
    countDownNum -= 1
    print("====NSTimer czm===", countDownNum, Int(interval!))
    if interval ?? 0 <= 0 {
        removeTimer()
    } else {
        
    }
}

override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    if self.navigationController == nil {
        self.removeTimer()
    }
    
}

// MARK: - Timer 闭包 的方式实现计时器

do {
    weak var timer: Timer?
    
    /// 添加倒计时
    /// - Parameter seconds: 总秒数
    private func addTimer(seconds: Int) {
        removeTimer()
        
        let endTime = Date(timeIntervalSinceNow: TimeInterval(seconds))
        let tmpTimer = Timer(timeInterval: 1, repeats: true) {[weak self] (t) in
            let interval = endTime.timeIntervalSinceNow
            let integerCount = Int(ceil(interval))
            if integerCount <= 0 {
                self?.removeTimer()
            } else {
                print("====update===", integerCount)
            }
        }
        RunLoop.current.add(tmpTimer, forMode: .common)
        tmpTimer.fire()
        timer = tmpTimer
    }
    
    
    private func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

// MARK: - OC 的方式实现计时器

int seconds = 60;

dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);

NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
dispatch_source_set_event_handler(timer, ^{
int interval = [endTime timeIntervalSinceNow];
if (interval <= 0) {
dispatch_source_cancel(timer);
dispatch_async(dispatch_get_main_queue(), ^{
NSLog(@"end");
});
} else {
dispatch_async(dispatch_get_main_queue(), ^{
NSLog(@"%d",interval);
});
}
});
dispatch_resume(timer);


// MARK: - 实现计时器执行

/// 数据刷新倒计时
private weak var timer: Timer?

/// 添加刷新定时器
private func addTimer() {
    removeTimer()
    let tmpTimer = Timer(timeInterval: 2, repeats: true) { [weak self] (t) in
        print("===czm===", t)
    }
    RunLoop.current.add(tmpTimer, forMode: .common)
    tmpTimer.fire()
    timer = tmpTimer
}

/// 移除刷新计时器
private func removeTimer() {
    self.timer?.invalidate()
    self.timer = nil
}


/// https://mp.weixin.qq.com/s/-MejEAp8nQI4Vctsk8A_aw

do {
    /// 重启timer
    func stratTimer() {
        self.timer?.fireDate = Date.distantPast
    }
    
    /// 暂停timer
    func pauseTimer() {
        self.timer?.fireDate = Date.distantFuture
    }
}

// MARK: - 在合适的时机移除 timer

do {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let _ = self.navigationController {
            self.removeTimer()
        }
    }
}
