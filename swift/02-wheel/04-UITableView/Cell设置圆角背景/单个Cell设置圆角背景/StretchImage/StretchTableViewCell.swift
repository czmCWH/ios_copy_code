/*
 
 这种方式还原度比较高，但是注意UI切图，需要 @2x、@3x 图。
 
 func resizableImage(withCapInsets capInsets: UIEdgeInsets, resizingMode: UIImage.ResizingMode) -> UIImage
 
 */

import UIKit

class StretchTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        let imgView = UIImageView()
        if let img = UIImage(named: "corner_bg_icon") {
            let leftCap = img.size.width * 0.5
            let topCap = img.size.height * 0.5
//            let newImg = img.stretchableImage(withLeftCapWidth: Int(leftCap), topCapHeight: Int(topCap))
            let newImg = img.resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), resizingMode: .stretch)
            imgView.image = newImg
        }
        self.contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
        }
        
    }
    
    func setupConstraints() {
        
    }

}
