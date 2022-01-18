 /* 使用方式：
 
 适合轻量级、显示弹框内容
 
 private weak var alertView: ZMAlertView?
 
 func tapAction() {
     let alertView = ZMAlertView(title: "好好学习好好学习好好学习好好学习好好学习好好学习？")
     alertView.show(self.navigationController?.view)
     alertView.sureClosure = { [weak self] in
     print("====cancel")
     }
 }
 
 */

import UIKit

/// 添加到 UIView 上的 alertView
class ZMAlertView: UIView {

    lazy var bgView: UIView! = UIView(frame: UIScreen.main.bounds)
    
    private lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 17)
        lab.textColor = UIColor(0x404040)
        lab.textAlignment = .center
        return lab
    }()

    private lazy var hLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(0xE5E5E5)
        return v
    }()
    
    private lazy var vLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(0xE5E5E5)
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    var cancelClosure: (() -> ())?
    var sureClosure: (() -> ())?
    
    init(title: String) {
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
        
        self.titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = self.superview else { return }
        
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
    
        titleLabel.numberOfLines = 0
        self.addSubview(titleLabel)
    
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("取消", for: .normal)
        btn1.setTitleColor(UIColor(0x777777), for: .normal)
        btn1.titleLabel?.font =  UIFont.systemFont(ofSize: 17)
        btn1.addTarget(self, action: #selector(clickCancelAciton(_:)), for: .touchUpInside)

        let btn2 = UIButton(type: .custom)
        btn2.setTitle("确定", for: .normal)
        btn2.setTitleColor(UIColor(0x333333), for: .normal)
        btn2.titleLabel?.font =  UIFont.systemFont(ofSize: 17)
        btn2.addTarget(self, action: #selector(clickSureAciton(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(btn1)
        stackView.addArrangedSubview(btn2)
        self.addSubview(stackView)
        
        self.addSubview(hLineView)
        self.addSubview(vLineView)
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(15)
            $0.leading.equalTo(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.greaterThanOrEqualTo(80)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview()
        }
        
        hLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(stackView.snp.top)
            $0.height.equalTo(1)
        }
        
        vLineView.snp.makeConstraints {
            $0.top.equalTo(hLineView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
        }
    }
    
    
    
    @objc private func clickCancelAciton(_ btn: UIButton) {
        self.dismiss()
        self.cancelClosure?()
    }
    
    @objc private func clickSureAciton(_ btn: UIButton) {
        self.dismiss()
        self.sureClosure?()
    }
    
    /// 显示alert View
    func show(_ inView: UIView?) {
        
        guard let inView = inView else { return }
        inView.addSubview(self)
        self.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
        
        self.superview?.endEditing(true)
        self.bgView.alpha = 0.0
        self.bgView.isHidden = false
        
        self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.bgView.alpha = 1.0
            self.transform = .identity
        } completion: { (_) in
           
        }
    }
    
    @objc private func dismiss() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.alpha = 0.0
            self.bgView.alpha = 0.0
        } completion: { (_) in
            self.bgView.isHidden = true
            self.removeFromSuperview()
            self.bgView?.removeFromSuperview()
        }
    }
}
