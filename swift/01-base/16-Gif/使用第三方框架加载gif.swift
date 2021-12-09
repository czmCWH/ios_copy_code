/*
 
 在iOS 15上，SDWebImage 和 Kingfisher 加载 gif 都会出现 [SDImageIOAnimatedCoder createFrameAtIndex:source:scale:preserveAspectRatio:thumbnailSize:options:] 崩溃，这是苹果的bug，等Xcode 13.2发布后才能修复。
 
 FLAnimatedImage 是 SDWebImage 用来支持 gif 的插件，在 SDWebImage 的github上有介绍。
 
 */



// MARK: - SDWebImage 方式加载

do {
    
    // 1、加载本地
    let imgView = SDAnimatedImageView()
    imgView.runLoopMode = .default
    imgView.image = SDAnimatedImage(named: "tag_light_twinkle.gif")
    imgView.contentMode = .scaleAspectFit
    
    // 2、加载网络图片
    let imgView = SDAnimatedImageView()
    imgView.contentMode = .scaleAspectFit
    imgView.sd_setImage(with: URL(string: "https://www.123.gif"), placeholderImage: UIImage(named: ""))
}

// MARK: - SDWebImageFLPlugin 方式加载

import SDWebImageFLPlugin

do {
    // 1、加载本地
     let imgView = FLAnimatedImageView()
    
    // let url: URL? = Bundle.main.url(forResource: "tag_light_twinkle", withExtension: "gif")
    
     if let path = Bundle.main.path(forResource:"tag_light_twinkle", ofType:"gif"),
         let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
             imgView.animatedImage = FLAnimatedImage(animatedGIFData: data)
     }
     self.view.addSubview(imgView)
    
    // 2、加载网络图片
    let imgView = FLAnimatedImageView()
    imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.gif"))
}

// MARK: - Kingfisher 方式加载

do {
    // 1、加载本地
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit

    let path = Bundle.main.path(forResource:"tag_light_twinkle", ofType:"gif")
    let url = URL(fileURLWithPath: path!)
    let provider = LocalFileImageDataProvider(fileURL: url)
    imgView.kf.setImage(with: provider)
    
    // 2、加载网络图片
    imageView.kf.setImage(with: url)
}

// MARK: - Gifu 方式加载

import Gifu

do {
    // 1、加载本地
    let imgView = GIFImageView(frame: .zero)
    imgView.contentMode = .scaleAspectFit
    imgView.animate(withGIFNamed: "tag_light_twinkle")

    
    // 2、加载网络图片
    let imgView = GIFImageView(frame: .zero)
    imgView.contentMode = .scaleAspectFit
    imgView.animate(withGIFURL: URL(string: "https://www.123.gif")!)
}
