//
//  PhotoItemCell.swift
//  DragCollectionCell
//
//  Created by czm on 2022/3/30.
//

import UIKit

class PhotoItemCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
