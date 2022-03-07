

import UIKit
import WebKit
import StoreKit

class NextViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    var presIdx: Int = 0
    var clickInt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "next"
        self.view.backgroundColor = .white
    
        
    
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        for _ in 0...5 {
            let v = UIView()
            v.backgroundColor = UIColor(0xD8D8D8)
            v.layer.cornerRadius = 2
            v.layer.masksToBounds = true
            stackView.addArrangedSubview(v)
            v.snp.makeConstraints {
                $0.width.equalTo(4)
                $0.height.equalTo(4)
            }
        }
        
        createActionBtn()
        
        
    }
    
    func createActionBtn() {
        let btn1 = UIButton(type: .custom)
        btn1.backgroundColor = .orange
        btn1.addTarget(self, action: #selector(clickBtn1(_:)), for: .touchUpInside)

        let btn2 = UIButton(type: .custom)
        btn2.backgroundColor = .blue
        btn2.addTarget(self, action: #selector(clickBtn2(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [btn1, btn2])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 35
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 45))
            $0.centerX.equalToSuperview()
            $0.top.equalTo(200)
        }
    }
    
    
    
    
    
    
    @objc func clickBtn1(_ btn: UIButton) {
        clickPage(indx: clickInt)
        if clickInt >= 5 { return }
        clickInt += 1
   
    }
    
    
    @objc func clickBtn2(_ btn: UIButton) {
        if clickInt <= 0 { return }
        clickInt -= 1
        clickPage(indx: clickInt)
    }
    
    func clickPage(indx: Int) {
        stackView.arrangedSubviews[self.presIdx].snp.updateConstraints {
            $0.width.equalTo(4)
        }
        stackView.arrangedSubviews[self.presIdx].backgroundColor = UIColor(0xD8D8D8)
        
        stackView.arrangedSubviews[indx].snp.updateConstraints {
            $0.width.equalTo(11)
        }
        stackView.arrangedSubviews[indx].backgroundColor = UIColor(0xF9550A)
        
        self.presIdx = indx
    }

    
}


class Person: NSObject {
    var age: Int
    
    lazy var name: String? = {
        return "czm的年龄是：\(age)"
    }()
    
    init(age: Int) {
        self.age = age
        super.init()
    }
}


extension String {
    
    /// 判断字符串是否包含中文、空格
    /// - Returns: true：有中文、空格
    func includeChinese() -> Bool {
        if self.contains(" ") { return true }
        for chart in self {
            let str = String(chart)
            if ("\u{4E00}" <= str  && str <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    /// 图片URL百分号转码
    func replaceImgUrl() -> String {
        if self.includeChinese() {
            let str = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            return str
        } else {
            return self
        }
    }
}
