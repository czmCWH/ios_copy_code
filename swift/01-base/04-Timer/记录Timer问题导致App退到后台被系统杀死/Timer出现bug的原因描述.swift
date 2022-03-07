
import Foundation

/*
 
 博客讲解：  (iOS app退到后台经常被杀，重新启动体验很差)[https://www.jianshu.com/p/f4385ad5b076]
 
 https://juejin.cn/post/6956368092830285860
 
 */

private let countDown = CountDown()

///秒杀还未开始倒计时
countDown.countDown(withStratDate: currentDate as Date, finish: startDate as Date) {[weak self] day, hour, minute, second in
    let hourStr = String.init(format: "%02d", hour)
    let minuteStr = String.init(format: "%02d", minute)
    let secondStr = String.init(format: "%02d", second)
    self?.hourLabel.text = hourStr
    self?.minuteLabel.text = minuteStr
    self?.secondLabel.text = secondStr
    self?.dayLabel.text = "\(day)天"
    self?.spikeBkImageView.image = UIImage(named: "goodsdetail_spiketwo_bkimage")
    self?.tipLabel.text = "距开始还剩"
    if day == 0 {
        self?.dayLabel.isHidden = true
    }else {
        self?.dayLabel.isHidden = false
    }

    if day == 0 && hour == 0 && minute == 0 && second == 0 {
        /// 再次请求刷新接口，防止时间有误（用户更改时间，用户停留商品详情直至活动开始导致接口一开始nowTime不对）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            NotificationCenter.default.post(name: .UpdateProductDetailDataNotification, object: nil)
        }
        
    }
}

///秒杀开始倒计时
handleSpikeActivityStartCountdown(startDate: currentDate, endDate: endDate)


deinit {
    self.countDown.destoryTimer()
}
