
/* 父子控制器
 
 https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller
 
 
 容器VC 通过将内容与屏幕上显示内容的方式分离，从而促进更好的封装。
 
 容器VC 将 子VC 的视图合并到它自己的视图层次结构中。每个子视图继续管理自己的视图层次结构，但 容器VC 管理该子视图的根视图的位置和大小。
 
 建立 父子VC 可以防止 UIKit 无意中干扰您的界面。UIKit 通常独立地将信息路由到您应用程序的每个 VC。当 父子VC 关系存在时，UIKit 首先通过 容器VC 路由许多请求，让它有机会改变任何 子VC 的行为。例如，容器VC 可能会覆盖其 子VC 的特征，迫使它们采用特定的外观或行为。
 */

import UIKit

class ParentViewController: UIViewController {

    weak var childOrangeVc: ChildViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let addBtn = UIButton(type: .custom)
        addBtn.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        addBtn.setTitle("添加", for: .normal)
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addBtn.addTarget(self, action: #selector(clickAdd(_:)), for: .touchUpInside)
        
        let removeBtn = UIButton(type: .custom)
        removeBtn.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        removeBtn.setTitle("移除", for: .normal)
        removeBtn.setTitleColor(.black, for: .normal)
        removeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        removeBtn.addTarget(self, action: #selector(clickRemove(_:)), for: .touchUpInside)
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 35
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 45))
            $0.centerX.equalToSuperview()
            $0.top.equalTo(100)
        }
        stackView.addArrangedSubview(addBtn)
        stackView.addArrangedSubview(removeBtn)
        
    }

    
    // 添加 child Vc 到 container Vc 的步骤如下
    @objc private func clickAdd(_ btn: UIButton) {
        
        if let _ = self.childOrangeVc {
            return
        }
        
        let childVc = ChildViewController()
        self.childOrangeVc = childVc
        
        self.addChild(childVc)
        self.view.addSubview(childVc.view)
        childVc.view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 150, left: 0, bottom: 150, right: 0))
        }
        childVc.didMove(toParent: self)
    }
   
    // 从 container Vc 中移除 child Vc 的步骤如下
    @objc private func clickRemove(_ btn: UIButton) {
        
        guard let childVc = self.childOrangeVc else { return }
        
        childVc.willMove(toParent: self)
        childVc.view.snp.removeConstraints()
        childVc.view.removeFromSuperview()
        childVc.removeFromParent()
        
    }
    
}

class ChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    

    deinit {
        print(#function)
    }

}
