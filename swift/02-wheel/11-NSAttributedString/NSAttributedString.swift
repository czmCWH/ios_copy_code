//
//  NSAttributedString.swift
//  test01
//
//  Created by czm on 2021/9/6.
//

import Foundation


// 设置富文本的两种方式

do {
    let lab = UILabel()
    lab.numberOfLines = 0
    let str = "正常正常红红红正常正常绿绿绿绿正常正常"
    let attri = NSMutableAttributedString(string: str)
    
    let blackAttri: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black]
    let redAttri: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.red]
    let greenAttri: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.green]
    
    attri.addAttributes(blackAttri, range: NSRange(location: 0, length: 4))
    attri.addAttributes(redAttri, range: NSRange(location: 4, length: 3))
    attri.addAttributes(blackAttri, range: NSRange(location: 7, length: 4))
    attri.addAttributes(greenAttri, range: NSRange(location: 11, length: 4))
    attri.addAttributes(blackAttri, range: NSRange(location: 15, length: 4))
    lab.attributedText = attri
    self.view.addSubview(lab)
    
    lab.snp.makeConstraints {
        $0.leading.equalTo(15)
        $0.trailing.equalToSuperview().offset(-15)
        $0.top.equalTo(200)
        $0.centerX.equalToSuperview()
    }
}


do {
    let lab = UILabel()
    lab.numberOfLines = 0
    let str = "正常正常红红红正常正常绿绿绿绿正常正常"
    
    let norAttri: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black]
    let attri = NSMutableAttributedString(string: str, attributes: norAttri)
    
    let redStr = "红红红"
    let redRange = (str as NSString).range(of: redStr)
    let redAttri: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.red]
    attri.addAttributes(redAttri, range: redRange)
    
    let greenStr = "绿绿绿绿"
    let greenRange = (str as NSString).range(of: greenStr)
    let greenAttri: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.green]
    attri.addAttributes(greenAttri, range: greenRange)
    
    lab.attributedText = attri
    self.view.addSubview(lab)
}
