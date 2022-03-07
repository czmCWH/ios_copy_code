//
//  TotalCountCell.swift
//  UITableView列表倒计时
//
//  Created by czm on 2022/2/21.
//

import UIKit
import SnapKit

class TotalCountCell: UITableViewCell {
    
    var leftLabel: UILabel!
    var rightLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftLabel = UILabel()
        leftLabel.font = UIFont.systemFont(ofSize: 14)
        leftLabel.textAlignment = .left
        leftLabel.textColor = .black
        self.contentView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        rightLabel = UILabel()
        rightLabel.font = UIFont.systemFont(ofSize: 14)
        rightLabel.textColor = .blue
        rightLabel.textAlignment = .right
        self.contentView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
