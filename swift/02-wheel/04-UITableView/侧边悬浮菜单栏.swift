//
//  MenuView.swift
//  test01
//
//  Created by michael on 2021/6/25.
//

/* 使用方式
 let menuV = ZMMenuView()
 view.addSubview(menuV)
 menuV.snp.makeConstraints {
     $0.top.equalToSuperview().offset(200)
     $0.leading.bottom.equalToSuperview()
     $0.width.equalTo(105)
 }
 */

import UIKit
import SnapKit

/// 分类首页左侧菜单View，用 UITableView 实现，tableView侧边栏，使cell浮起来
class ZMMenuView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    private var menuTableView: UITableView!
    
    private var selectIdx: Int = 0
    
    /// 点击菜单Item
    var selectMenuItemClosure: ((Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        menuTableView = UITableView(frame: .zero, style: .plain)
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.separatorStyle = .singleLine
        menuTableView.separatorInset = .zero
        menuTableView.separatorColor = .red
        menuTableView.rowHeight = 55
        menuTableView.showsVerticalScrollIndicator = false
        menuTableView.backgroundColor = .gray
        menuTableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            menuTableView.contentInsetAdjustmentBehavior = .never;
        }
        menuTableView.register(KDBrandHomeMenuCell.self, forCellReuseIdentifier: KDBrandHomeMenuCell.reuseIdentifier)
        self.addSubview(menuTableView)
        
        menuTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KDBrandHomeMenuCell.reuseIdentifier, for: indexPath) as? KDBrandHomeMenuCell else { fatalError("\(KDBrandHomeMenuCell.self)获取失败") }
        cell.nameLabel.text = "\(indexPath.row)--商品"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIdx = indexPath.row
        menuTableView.reloadData()
        let index = IndexPath(row: self.selectIdx, section: 0)
        menuTableView.selectRow(at: index, animated: true, scrollPosition: .none)
        self.selectMenuItemClosure?(indexPath.row)
    }

}

class KDBrandHomeMenuCell: UITableViewCell {
    static let reuseIdentifier = "KDBrandHomeMenuCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                bgView.isHidden = false
                self.contentView.layer.zPosition = 0
            } else {
                bgView.isHidden = true
                self.contentView.layer.zPosition = 1
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(bgView)
        self.contentView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(10)
        }
        
        nameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
    }
}



