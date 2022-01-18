
// MARK: - ----------------------- Notification -----------------------

NotificationCenter.default.post(name: NSNotification.Name("notify_info"), object: self, userInfo: ["code": 100])

NotificationCenter.default.addObserver(self, selector: #selector(notificationAction(_:)), name: NSNotification.Name("notify_info"), object: nil)

NotificationCenter.default.removeObserver(self)

@objc private func notificationAction(_ notify: Notification) {
    switch notify.name {
    case NSNotification.Name("notify_info"):
        print("===czm==\(type(of: notify.object))")
    default:
        break
    }
}


// MARK: - ------------------ 布局代码 -----------------------
{
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height: CGFloat = 40.0
        let width: CGFloat = UIScreen.main.bounds.width
        let y: CGFloat = UIScreen.main.bounds.height / 2.0 - height / 2.0
        redButton.frame = CGRect(x: 0, y: y, width: width, height: height)
    }
}

