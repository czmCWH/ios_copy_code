
import UIKit
import AVFoundation

do {
    var player: AVPlayer?
    
    var playerItemContext: Void?
    
    func prepareToPlay() {
        
        // 配置当使用蜂窝网络时，允许加载视频播放。
        let options = [AVURLAssetAllowsCellularAccessKey: true]
        let asset = AVURLAsset(url: URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/803lpnlacvg2jsndx/803/hls_vod_mvp.m3u8")!, options: options)
        
        // 一组字符串，代表一个由 AVAsset 定义的属性键，例如：duration、preferredRate
        let assetKeys = ["playable", "hasProtectedContent" ]
        let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKeys)
        // 监听播放状态
        playerItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)
        
        let player = AVPlayer(playerItem: playerItem)
        self.player = player
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.player = player
        playerLayer.frame = CGRect(x: 50, y: 200, width: self.view.frame.size.width - 100, height: 200)
        playerLayer.backgroundColor = UIColor.white.cgColor
        playerLayer.videoGravity = .resizeAspect
        
        self.view.layer.addSublayer(playerLayer)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        (object as? AVPlayerItem)?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusValue = change?[.newKey] as? Int {
                status = AVPlayerItem.Status(rawValue: statusValue)!
            } else {
                status = .unknown
            }
            
            switch status {
            case .readyToPlay:
                print("Player item is ready to play.")
                player?.play()
            case .failed:
                print("Player item failed. See error.")
            case .unknown:
                print("Player item is not yet ready.")
            default: break
            }
        }
    }
}
