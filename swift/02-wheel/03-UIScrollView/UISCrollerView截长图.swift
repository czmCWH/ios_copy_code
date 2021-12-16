
import UIKit

// 参考自：https://juejin.cn/post/6943896363126145031

do {
    
    /// 截长图
    func snapshotScreen(scrollView: UIScrollView) -> UIImage?{
        if UIScreen.main.responds(to: #selector(getter: UIScreen.scale)) {
            UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, false, UIScreen.main.scale)
        } else {
            UIGraphicsBeginImageContext(scrollView.contentSize)
        }
        
        let savedContentOffset = scrollView.contentOffset
        let savedFrame = scrollView.frame
        let contentSize = scrollView.contentSize
        let oldBounds = scrollView.layer.bounds
        
        if #available(iOS 13, *) {
            //iOS 13 系统截屏需要改变tableview 的bounds
            scrollView.layer.bounds = CGRect(x: oldBounds.origin.x, y: oldBounds.origin.y, width: contentSize.width, height: contentSize.height)
        }
        //偏移量归零
        scrollView.contentOffset = CGPoint.zero
        //frame变为contentSize
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        
        //截图
        if let context = UIGraphicsGetCurrentContext() {
            scrollView.layer.render(in: context)
        }
        if #available(iOS 13, *) {
            scrollView.layer.bounds = oldBounds
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //还原frame 和 偏移量
        scrollView.contentOffset = savedContentOffset
        scrollView.frame = savedFrame
        return image
    }
}
