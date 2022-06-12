//
//  ZMSheetView.swift
//  test01
//
//  Created by czm on 2021/9/7.
//
/* 使用方式：
 
 private var sheetView: ZMSheetView?
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     sheetView = ZMSheetView()
     sheetView?.didSelectClosure = { [weak self] in
         print("====xx")
     }
     self.navigationController?.view.addSubview(sheetView!)
 }
 
 func tapAction() {
    self.sheetView?.show()
 }
 
 deinit {
     self.sheetView?.removeFromSuperview()
 }
 
 
 
 
 https://developer.apple.com/design/human-interface-guidelines/components/presentation/action-sheets/
 */

import UIKit

/// 添加到 UIView 上的 sheetView
class ZMSheetView: UIView, UITableViewDataSource, UITableViewDelegate {

    lazy var bgView: UIView! = UIView(frame: UIScreen.main.bounds)
    
    private lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = UIColor(0x141414)
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "refund_apply_sheet_cancelImg"), for: .normal)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(0xFFFFFF)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        tableView.separatorColor = UIColor(0xE7E7E7)
//        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never;
//        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ZMSheetCell.self, forCellReuseIdentifier: ZMSheetCell.reuseIdentifier)
        return tableView
    }()
    
    
    /// 选择模型的回调
    var didSelectClosure: (() -> ())?
    
    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        maskPath.close()
        
        UIColor(0xFFFFFF).setFill()
        maskPath.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = self.superview else { return }
        
        self.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(UIScreen.main.bounds.size.height)
        }
        
        self.superview?.insertSubview(self.bgView, belowSubview: self)
    }
    
    override func removeFromSuperview() {
        self.bgView.removeFromSuperview()
        super.removeFromSuperview()
    }
    
    private func setupUI() {
        bgView.isHidden = true
        bgView?.backgroundColor = UIColor(0x000000).withAlphaComponent(0.25)
        bgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        bgView.addGestureRecognizer(tap)
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(0xFFFFFF)
        
        titleLabel.text = "请选择"
        self.addSubview(titleLabel)
    
        cancelBtn.addTarget(self, action: #selector(clickCancelAciton(_:)), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints {
            $0.size.equalTo((CGSize(width: 47, height: 47)))
            $0.trailing.equalTo(-3)
            $0.centerY.equalTo(titleLabel)
        }
        
        let tableH = 44 * 6
        tableView.snp.makeConstraints {
            $0.height.equalTo(tableH)
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 47, left: 0, bottom: 0, right: 0))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ZMSheetCell.reuseIdentifier, for: indexPath) as? ZMSheetCell else { fatalError("\(ZMSheetCell.self)获取失败") }
        cell.selectionStyle = .none
        cell.titleLabel.text = "第---\(indexPath.row)行"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadData()
        self.didSelectClosure?()
        self.dismiss()
    }
    
    @objc private func clickCancelAciton(_ btn: UIButton) {
        self.dismiss()
    }
    
    func show() {
        
        self.tableView.reloadData()
        
        self.superview?.endEditing(true)
        self.bgView.alpha = 0.0
        self.bgView.isHidden = false
        let offY = UIScreen.main.bounds.size.height - self.frame.size.height
        self.snp.updateConstraints {
            $0.top.equalTo(offY)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.bgView.alpha = 1.0
            self.superview?.layoutIfNeeded()
        } completion: { (_) in
           
        }

    }
    
    @objc private func dismiss() {
        
        self.snp.updateConstraints {
            $0.top.equalTo(UIScreen.main.bounds.size.height)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.bgView.alpha = 0.0
            self.superview?.layoutIfNeeded()
        } completion: { (_) in
            self.bgView.isHidden = true
        }
    }
}


fileprivate class ZMSheetCell: UITableViewCell {

    static let reuseIdentifier = "ZMSheetCell"
    
    var titleLabel: UILabel!
    var iconBtn: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(0xFFFFFF)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor(0x404040)
        titleLabel.textAlignment = .left
        titleLabel.text = "null"
        self.contentView.addSubview(titleLabel)
        
        iconBtn = UIButton(type: .custom)
        iconBtn.isUserInteractionEnabled = false
//        iconBtn.setImage(UIImage(named: "order_refun_sheet_uncheck"), for: .normal)
//        iconBtn.setImage(UIImage(named: "order_refun_sheet_check"), for: .selected)
        iconBtn.isSelected = false
        self.contentView.addSubview(iconBtn)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(15)
            $0.trailing.equalToSuperview().offset(-50)
            $0.centerY.equalToSuperview()
        }
        
        iconBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 18, height: 18))
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
}
