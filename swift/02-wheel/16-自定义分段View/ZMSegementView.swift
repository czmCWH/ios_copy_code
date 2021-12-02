
/* 分段组件：类似于常用的购物app头部标签View
 利用 UIScrollView 实现，参考自 https://github.com/Danie1s/DNSPageView
 
 ---- 使用方式
 
 let segementView = ZMSegementView()
 segementView.backgroundColor = .red
 segementView.selectedIndex = 3
 segementView.clickItemClosure = { [weak self] idx in
     print("===czm===", idx)
 }
 self.view.addSubview(segementView)
 
 segementView.snp.makeConstraints {
     $0.leading.trailing.equalToSuperview()
     $0.top.equalTo(300)
     $0.height.equalTo(46)
 }
 
 */


import UIKit

class ZMSegementView: UIView {
    
    private var titles = ["全部", "待付款", "待发货", "已发货", "已完成", "已关闭"]
    
    private var norBtnW: [CGFloat] = []
    private var selBtnW: [CGFloat] = []
    
    private var scrollView: UIScrollView!
    private var containerStackView: UIStackView!
    
    /// 上一次点击的 btn
    private var previousBtn: KDPOrderCenterTitleButton!
    /// 下划线 View
    private var lineView: UIView!
    
    /// 设置当前选中的索引
    var selectedIndex: Int = 0 {
        didSet {
            guard let btn = containerStackView.viewWithTag(selectedIndex + 100) as? KDPOrderCenterTitleButton else { return }
            self.clickIndexButton(btn)
        }
    }
    
    /// 选中索引的回调
    var clickItemClosure: ((Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = UIColor(0xF5F5F5)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView = UIStackView()
        containerStackView.axis = .horizontal
        containerStackView.alignment = .center
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing = 0
        scrollView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        for (idx, str) in titles.enumerated() {
            let btn = KDPOrderCenterTitleButton(type: .custom)
            btn.tag = idx + 100
            btn.setTitle(str, for: .normal)
            btn.setTitleColor(UIColor(0x404040), for: .normal)
            btn.setTitleColor(UIColor.red, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(clickIndexButton(_:)), for: .touchUpInside)
            containerStackView.addArrangedSubview(btn)
            let norWidth = str.sizeTextWidth(font: UIFont.systemFont(ofSize: 15)) + 26
            self.norBtnW.append(norWidth)
            let selWidth = str.sizeTextWidth(font: UIFont.systemFont(ofSize: 18)) + 26
            self.selBtnW.append(selWidth)
            
            if idx == 0 {
                btn.isSelected = true
                btn.snp.makeConstraints {
                    $0.height.equalToSuperview()
                    $0.width.equalTo(selWidth)
                }
                self.previousBtn = btn
            } else {
                btn.snp.makeConstraints {
                    $0.height.equalToSuperview()
                    $0.width.equalTo(norWidth)
                }
            }
        }
        
        lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 35, width: 22, height: 2)
        lineView.frame.origin.x = self.selBtnW.first! * 0.5 - 11
        lineView.backgroundColor = UIColor(0xFA550A)
        lineView.layer.cornerRadius = 1
        scrollView.addSubview(lineView)
        
    }
    
    @objc private func clickIndexButton(_ btn: KDPOrderCenterTitleButton) {
        
        let selWidth = self.selBtnW[btn.tag - 100]
        let norWidth = self.norBtnW[self.previousBtn.tag - 100]
        
        self.previousBtn.isSelected = false
        previousBtn.snp.updateConstraints {
            $0.width.equalTo(norWidth)
        }
        btn.isSelected = true
        btn.snp.updateConstraints {
            $0.width.equalTo(selWidth)
        }
        self.previousBtn = btn
        let idx = btn.tag - 100
        UIView.animate(withDuration: 0.25) {
            self.lineView.center.x = btn.center.x
        } completion: { _ in
            self.clickItemClosure?(idx)
            self.adjustLabelPosition(self.previousBtn, animated: true)
        }
    }
    
    fileprivate func adjustLabelPosition(_ targetBtn: KDPOrderCenterTitleButton, animated: Bool) {
        guard scrollView.contentSize.width > scrollView.frame.width else { return }
        var offsetX = targetBtn.center.x - frame.width * 0.5
        
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollView.contentSize.width - scrollView.frame.width {
            offsetX = scrollView.contentSize.width - scrollView.frame.width
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
    }
}

fileprivate class KDPOrderCenterTitleButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            } else {
                self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {}
    }
}
