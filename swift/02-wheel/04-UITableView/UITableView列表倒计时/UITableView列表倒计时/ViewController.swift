/*
 
 问题：在一个列表中实现一个倒计时？
 难点：
    1、Timer的 创建 和 销毁
    2、App进入后台的时间间隔
    3、如何更新Cell
        
 
 方式一：
 
    1、在VC中添加 Timer
    2、Timer更新时，刷新 tableView.visibleCells
 
 
 方式二：
 
    1、在VC中添加 Timer
    2、Timer更新时，发送通知，刷新每个Cell
 
 也可以看看第三方：
 https://github.com/herobin22/OYCountDownManager-Swift iOS在cell中使用倒计时的处理方法, 全局使用一个NSTimer对象, 支持单列表.多列表.多页面.分页列表使用
 
 */





import UIKit

class ViewController: UIViewController {
    
    var startTime: Double = 0
    
    var startDt: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.lessThanOrEqualTo(UIScreen.main.bounds.size.width - 60)
        }
        
        let btn1 = createBtn(title: "开启一个Timer，每隔一秒把所有需要倒计时的模型减1，然后更新所有可见cell")
        btn1.addTarget(self, action: #selector(clickBtn1Action(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(btn1)
        btn1.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }
        
        let btn2 = createBtn(title: "开启一个Timer，每次 update 发送通知更新Cell，App退到后台累计intervalCount，回到前台再刷新")
        btn2.addTarget(self, action: #selector(clickBtn2Action(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(btn2)
        btn2.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }
        
        startTime = CACurrentMediaTime()
        startDt = Date()
        
    }
    
    func createBtn(title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        btn.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        btn.titleLabel?.numberOfLines = 0
        return btn
    }
    

    
    @objc func clickBtn1Action(_ btn: UIButton) {
        let vc = CountDownTableController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func clickBtn2Action(_ btn: UIButton) {
        let vc = TotalCountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 把秒转换为天时分秒
    private func timerStr(_ totalSeconds: Int) -> String {
        if totalSeconds <= 0 {
            return "00:00:00"
        }
        let days = totalSeconds/(24*3600)
        let hours = (totalSeconds / 3600) % 24
        let minutes = (totalSeconds / 60) % 60
        let seconds = totalSeconds % 60
        
        if days != 0 {
            return String(format: "%d天%02d:%02d:%02d", days, hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
}

