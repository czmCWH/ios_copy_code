//
//  NextViewController.swift
//  test01
//
//  Created by michael on 2021/6/25.
//
/* 参考博客：
 swift5.3 UIScrollView 动态计算 contentSize：https://segmentfault.com/a/1190000037456477
 
 https://github.com/bestswifter/blog/blob/master/articles/uiscrollview-with-autolayout.md
 
 */


import UIKit

/// UIScrollView 的滚动范围由其子View决定
class TempViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var containerStackView: UIStackView!
    
    lazy var redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    lazy var greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    lazy var blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = UIColor(0xF5F5F5)
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.alignment = .top
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing = 10
        scrollView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.top.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 20)
            $0.bottom.equalToSuperview()
        }
        
        containerStackView.addArrangedSubview(redView)
        redView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        containerStackView.addArrangedSubview(greenView)
        greenView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        containerStackView.addArrangedSubview(blueView)
        blueView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(300)
        }
    }


}
