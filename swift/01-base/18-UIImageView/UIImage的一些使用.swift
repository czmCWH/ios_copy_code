
import UIKit

// MARK: - 聊天框背景图片拉伸

do {
    let imgView = UIImageView()
    imgView.contentMode = .scaleToFill
    self.view.addSubview(imgView)
    
    imgView.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(150)
        $0.width.equalTo(200)
        $0.height.equalTo(80)
    }
    
    // 原图大小：98 x 74
    if let url = URL(string: "https://douhuo2.oss-cn-shanghai.aliyuncs.com/ddd4@2x.png"),
       let data = try? Data(contentsOf: url),
       let img = UIImage(data: data) {
        
        let leftCap = ceil(img.size.width * 0.5)
        let topCap = ceil(img.size.height * 0.5)
        
        let newImg = img.stretchableImage(withLeftCapWidth: Int(leftCap), topCapHeight: Int(topCap))
        imgView.image = newImg
    }
}

// MARK: - UIImage图片压缩
// https://www.jianshu.com/p/24155a2afe36
do {
    let imgData = UIImage(named: "good_icon")?.pngData()
    print("===czm===", imgData?.count)
    // 49KB
    // 45323
}
