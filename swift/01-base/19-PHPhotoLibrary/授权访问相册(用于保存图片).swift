
import UIKit
import Photos

do {
    
    switch status {
    case .notDetermined:
        print("===czm1===用户尚未设置应用的授权状态")
    case .restricted:
        print("===czm1===该应用无权访问照片库，用户无法授予此类权限。")
    case .denied:
        print("===czm1===用户明确拒绝此应用访问照片库。")
    case .authorized:
        print("===czm1===用户明确授予此应用访问照片库的权限。")
    case .limited:
        print("===czm1===用户授权此应用程序访问有限的照片库。")
    }
    
    /* 使用方式：
     
     let tableImg = snapshotScreen(scrollView: tableView)
     if let screenshotImage = tableImg {
         self.photoLibraryAuthorization {        // 权限方法：参照：01-base/20-PHPhotoLibrary/授权访问相册(用于保存图片)
             self.savePhoto(img: screenshotImage)
         }
     }
     */
    
    
    
    /// 判断相册访问权限
    func photoLibraryAuthorization(success: (() -> ())?) {
        let status: PHAuthorizationStatus
        if #available(iOS 14, *) {
            status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        } else {
            status = PHPhotoLibrary.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:    // 用户尚未设置应用的授权状态。
            self.photoLibraryRequestAuthorization(success: success)
        case .restricted:
            self.view.makeToast("无法授予相册访问权限，请检查你是否被限制授权！", duration: 2, position: .center)
        case .denied:
            self.jumpSettingPhoto("您的相册暂未允许访问，请去 设置-隐私-照片 里面授权!")
        case .authorized, .limited:
            success?()
        default:
            break
        }
    }
    
    /// 请求授权访问相册
    private func photoLibraryRequestAuthorization(success: (() -> ())?) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
                switch status {
                case .authorized, .limited:
                    success?()
                default: break
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized, .limited:
                    success?()
                default: break
                }
            }
        }
    }
    
    /// 弹框提示
    private func jumpSettingPhoto(_ tipStr: String) {
        let alert = UIAlertController(title: "温馨提示", message: tipStr, preferredStyle: .alert)
        let sure = UIAlertAction(title: "去设置", style: .default, handler: { [weak self] (_) in
            self?.openSetting()
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(sure)
        self.present(alert, animated: true, completion: nil)
    }

    /// 跳转到相册权限设置
    private func openSetting() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl) { (_) in
//                    print("跳转到设置页是否成功：\(res)")
            }
        }
    }
    
    
    /// 保存图片到相册
    private func savePhoto(img: UIImage) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: img)
        } completionHandler: { [weak self] (res, error) in
            DispatchQueue.main.async {
                if res {
                    self?.view.makeToast("保存成功", duration: 2, position: .center)
                } else {
                    self?.view.makeToast("保存失败", duration: 2, position: .center)
                }
            }
        }
    }
}
