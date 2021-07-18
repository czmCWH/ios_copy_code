
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
