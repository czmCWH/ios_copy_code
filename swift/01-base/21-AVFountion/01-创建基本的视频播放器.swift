/*
 
 AVPlayer、AVPlayerViewController 创建一个基本视频播放器，支持后台播放和画中画
 
 */

import UIKit
import AVKit
import AVFoundation

class BasicVideoPlayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let btn = UIButton(type: .custom)
        btn.setTitle("播放", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .orange
        btn.addTarget(self, action: #selector(clickPlayVideo(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: self.view.center.x - 30, y: 100, width: 60, height: 40)
        self.view.addSubview(btn)
        
        // 1、配置App支持后台播放：project -> TARGETS -> Sigining & Capabilities -> Background Modes -> 勾选 Audio, AirPlay, and Picture in Picture
        
        // 2、配置音频会话的类别和模式，也可以在 application(_:didFinishLaunchingWithOptions:) 进行配置
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // 是音频播放支持后台播放、画中画模式
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    @objc private func clickPlayVideo(_ btn: UIButton) {
        
        guard let url = URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/803lpnlacvg2jsndx/803/hls_vod_mvp.m3u8") else { return }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // AVPlayerViewController 用于显示 AVPlayer 对象的视觉内容和系统标准播放的控件
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
}
