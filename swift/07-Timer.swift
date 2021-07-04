

// MARK:- GCD的方式实现计时器

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


// MARK:- Timer 的方式实现计时器

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


// MARK:- OC 的方式实现计时器

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
