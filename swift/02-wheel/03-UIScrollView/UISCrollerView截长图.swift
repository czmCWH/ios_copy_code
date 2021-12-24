
import UIKit

extension UIScrollView {

    // 参考自：https://juejin.cn/post/6943896363126145031
    /// 截长图
    func snapshotScreen() -> UIImage? {
        if UIScreen.main.responds(to: #selector(getter: UIScreen.scale)) {
            UIGraphicsBeginImageContextWithOptions(self.contentSize, false, UIScreen.main.scale)
        } else {
            UIGraphicsBeginImageContext(self.contentSize)
        }
        
        let savedContentOffset = self.contentOffset
        let savedFrame = self.frame
        let contentSize = self.contentSize
        let oldBounds = self.layer.bounds
        
        if #available(iOS 13, *) {
            //iOS 13 系统截屏需要改变tableview 的bounds
            self.layer.bounds = CGRect(x: oldBounds.origin.x, y: oldBounds.origin.y, width: contentSize.width, height: contentSize.height)
        }
        //偏移量归零
        self.contentOffset = CGPoint.zero
        //frame变为contentSize
        self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        
        //截图
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
        }
        if #available(iOS 13, *) {
            self.layer.bounds = oldBounds
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //还原frame 和 偏移量
        self.contentOffset = savedContentOffset
        self.frame = savedFrame
        return image
    }
}

