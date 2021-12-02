/*
 
 适用于有交互逻辑处理较为复杂的页面
 
 使用方式：
 
 let vc = AlertToWindowViewController(fromVc: self)
 vc.cancelClosure = { [weak self] in
     
     print("======begin==")
     
     Thread.sleep(forTimeInterval: 5)
     
     print("======end==")
     
 }
 vc.show()
 
 */


import UIKit

class AlertToWindowViewController: UIViewController {
    
    // MARK: - UI properties
    
    var alertWindow: UIWindow!
    
    private var maskView: UIView!
    private var contentView: UIView!
    private var titleLabel: UILabel!
    private var textField: UITextField!
    private var btnsStackView: UIStackView!
    private var hLineView: UIView!
    private var vLineView: UIView!
    
    // MARK: - Stored properties
    
    weak var fromVc: UIViewController?
    
    var cancelClosure: (() -> ())?
    var sureClosure: (() -> ())?
    
    // MARK: - Lifecycle
    
    init(fromVc: UIViewController?) {
        self.fromVc = fromVc
        super.init(nibName: nil, bundle: nil)
        
        alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.backgroundColor = .clear
        alertWindow.windowLevel = UIWindow.Level.alert - 1
        alertWindow.rootViewController = self
        alertWindow.makeKeyAndVisible()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        
        setupUI()
        setupConstraints()
        
        self.maskView.isHidden = true
        self.contentView.isHidden = true
        self.maskView.alpha = 0.0
        self.contentView.alpha = 0.0
    }

    private func setupUI() {
        
        maskView = UIView()
        maskView.backgroundColor = UIColor(0x000000).withAlphaComponent(0.25)
        maskView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMaskViewAction(_:)))
        maskView.addGestureRecognizer(tap)
        self.view.addSubview(maskView)
        
        contentView = UIView()
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(0xFFFFFF)
        self.view.addSubview(contentView)
        
        titleLabel = UILabel()
        titleLabel.text = "温馨提示"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        
        textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.textColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textAlignment = .left
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .whileEditing
        contentView.addSubview(textField)
        
        btnsStackView = UIStackView()
        btnsStackView.axis = .horizontal
        btnsStackView.alignment = .fill
        btnsStackView.distribution = .fillEqually
        btnsStackView.spacing = 0
        contentView.addSubview(btnsStackView)
        
        hLineView = UIView()
        hLineView.backgroundColor = UIColor(0xE5E5E5)
        contentView.addSubview(hLineView)
        
        vLineView = UIView()
        vLineView.backgroundColor = UIColor(0xE5E5E5)
        contentView.addSubview(vLineView)
        
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
        btnsStackView.addArrangedSubview(btn1)
        btnsStackView.addArrangedSubview(btn2)
        
    }

    private func setupConstraints() {
        
        maskView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(10)
        }
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.height.equalTo(40)
            $0.leading.equalTo(23)
            $0.trailing.equalToSuperview().offset(-23)
        }
        
        btnsStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(textField.snp.bottom).offset(35)
        }
        
        hLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.top.equalTo(btnsStackView.snp.top)
        }
        
        vLineView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(btnsStackView)
            $0.width.equalTo(0.5)
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(270)
        }
        
    }
    
    func show() {
        self.maskView.isHidden = false
        self.contentView.isHidden = false
        
        self.contentView.alpha = 1.0
        self.contentView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.maskView.alpha = 1.0
            self.contentView.transform = .identity
        } completion: { (_) in
           
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.contentView.alpha = 0.0
            self.maskView.alpha = 0.0
        } completion: { (_) in
            self.alertWindow.isHidden = true
            self.alertWindow = nil
        }
    }
    
    @objc private func clickCancelAciton(_ btn: UIButton) {
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.contentView.alpha = 0.0
            self.maskView.alpha = 0.0
        } completion: { (_) in
            self.alertWindow.isHidden = true
            self.alertWindow = nil
            self.cancelClosure?()
        }
        
    }
    
    @objc private func clickSureAciton(_ btn: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.contentView.alpha = 0.0
            self.maskView.alpha = 0.0
        } completion: { (_) in
            self.alertWindow.isHidden = true
            self.alertWindow = nil
            self.sureClosure?()
        }
    }
    
    @objc private func tapMaskViewAction(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended:
            self.dismiss()
        default:
            break
        }
    }
    
    deinit {
//        print("====czm==== deinit alert vc")
    }

}
