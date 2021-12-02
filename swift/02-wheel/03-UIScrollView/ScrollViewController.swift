//
//  NextViewController.swift
//  test01
//
//  Created by michael on 2021/6/25.
//
/*
 UISrcollView 嵌套 UITableView + WKWebView，滚动范围自适应
 参考自：https://github.com/cnthinkcode/HSNatvieWebView
 
 */


import UIKit
import WebKit

class NextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var scrollView: UIScrollView!
    var tableView: UITableView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "next"
        self.view.backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .green
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.scrollsToTop = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        scrollView.addSubview(tableView)
            
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(0)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        webView = WKWebView()
        webView.addObserver(self, forKeyPath: "scrollView.contentSize", options: .new, context: nil)
        scrollView.addSubview(webView)
        webView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width)
            $0.top.equalTo(tableView.snp.bottom)
            $0.height.equalTo(0)
            $0.bottom.equalToSuperview()
        }
        
        let request = URLRequest(url: URL(string: "https://oss-test.manqu88.com/1121631953339009.html")!)
        webView.load(request)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let _ = object as? WKWebView {
            let h = webView.scrollView.contentSize.height
            webView.snp.updateConstraints {
                $0.height.equalTo(h)
            }
            
        }
        
        if let _ = object as? UITableView {
            let h = tableView.contentSize.height
            
            tableView.snp.updateConstraints {
                $0.height.equalTo(h)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .red
        cell.textLabel?.text = "==123===\(indexPath.row)"
        return cell
    }
   
    deinit {
        tableView.removeObserver(self, forKeyPath: "contentSize")
        webView.removeObserver(self, forKeyPath: "scrollView.contentSize")
    }
}
