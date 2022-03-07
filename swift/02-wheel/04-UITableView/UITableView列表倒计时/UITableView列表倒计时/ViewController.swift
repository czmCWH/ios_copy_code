//
//  ViewController.swift
//  UITableView列表倒计时
//
//  Created by czm on 2022/2/21.
//

import UIKit

class ViewController: UIViewController {

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
        btn1.addTarget(self, action: #selector(clickBtn2Action(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(btn1)
        btn1.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }
        
        let btn2 = createBtn(title: "开启一个Timer，累计进行了多少秒intervalCount，当前显示的cell的number count减去intervalCount")
        btn2.addTarget(self, action: #selector(clickBtn2Action(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(btn2)
        btn2.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }
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
}

