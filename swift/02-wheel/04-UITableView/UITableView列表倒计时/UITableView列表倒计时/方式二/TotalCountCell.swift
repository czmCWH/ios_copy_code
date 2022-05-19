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
    
    var model: CountDownModel? {
        didSet {
            guard let model = model else { return }

            self.leftLabel.text = "第\(model.idx)行"
            self.rightLabel.text = "可变数量：\(model.num)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveTimerUpdate(_:)), name: Notification.Name("CellUpdate"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func receiveTimerUpdate(_ notify: Notification) {
        
        guard let objNofity = notify.object else { return }
        var timeInterval: Int?
        switch notify.name {
        case Notification.Name("CellUpdate"):
            timeInterval = Int("\(objNofity)")
            break
        default:
            break
        }
        guard let timeInterval = timeInterval, let model = model else { return }
        model.num = model.num - timeInterval
        self.rightLabel.text = "可变数量：\(model.num)"
    }
}
