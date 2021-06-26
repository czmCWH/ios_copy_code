//
//  KDLoginProtocolViewController.swift
//  Kiddos
//
//  Created by michael on 2021/6/21.
//

import UIKit
import WebKit

/// 用于展示协议
class KDLoginProtocolViewController: KDZMBaseViewController {
    
    private lazy var webView = WKWebView()
    var urlStr: String = "https://www.baidu.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarDefault()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.webView.reload()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupUI() {
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        webView.scrollView.contentOffset = .zero
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        let request = URLRequest(url: URL(string: self.urlStr)!)
        webView.load(request)
        
        self.webView.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                $0.top.equalTo(self.topLayoutGuide.snp.top)
            }
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-49)
            } else {
                $0.bottom.equalTo(self.topLayoutGuide.snp.bottom).offset(-49)
            }
        }
    }
    
}


extension KDLoginProtocolViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("===didStart====", webView.estimatedProgress)
//        if self.isNetAvailable {
//            self.indicator.startAnimating()
//        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print("===didCommit====", webView.estimatedProgress)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        print("===didFail====", webView.estimatedProgress)
//        IndicatorView.hidden(self.indicator)
//        reloadButton.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////        print("====didFinish===", webView.estimatedProgress)
//        IndicatorView.hidden(self.indicator)
//        reloadButton.isHidden = true
    }
}
