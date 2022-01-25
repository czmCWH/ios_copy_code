
import UIKit


static var keyWindow:UIWindow? {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow})
            .first
    } else {
        return UIApplication.shared.windows
            .filter({$0.isKeyWindow})
            .first
    }
}
