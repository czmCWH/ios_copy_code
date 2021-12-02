//
//  PresentAlertViewController.swift
//  test01
//
//  Created by czm on 2021/10/14.
//

/*
 
 通过模态VC的方式进行Alert，这种方式适合没有动画效果，有动画的效果都很差。
 
 let vc = PresentAlertViewController()
 vc.modalPresentationStyle = .overFullScreen
 self.navigationController?.present(vc, animated: false, completion: nil)
 
 */

import UIKit

class PresentAlertViewController: UIViewController {
    
    private var bgView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(0x0F0F0F, 0.61)
        
        setupUI()
    }
    
    private func setupUI() {
        bgView = UIView()
        bgView.backgroundColor =  .white
        bgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickDismiss))
        bgView.addGestureRecognizer(tap)
        self.view .addSubview(bgView)
        
        bgView.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.height.equalTo(350)
            $0.center.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.bgView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.bgView.transform = .identity
        } completion: { (_) in
           
        }
    }
    

    @objc private func clickDismiss() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
            self.bgView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        } completion: { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
   

}
