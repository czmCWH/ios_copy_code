//
//  TotalCountViewController.swift
//  UITableView列表倒计时
//
//  Created by czm on 2022/2/21.
//

import UIKit
import SnapKit

class TotalCountViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var dataArray: [CountDownModel] = []
    
    weak var timer: Timer?
    var recordTime: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        tableView.backgroundColor = UIColor.white
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = UIColor.red
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TotalCountCell.self, forCellReuseIdentifier: "CellID")
        self.view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        DispatchQueue.global().async {
            for i in 10..<80 {
                let num = Int.random(in: 10...90)
                let model = CountDownModel(num)
                model.idx = i - 10
                self.dataArray.append(model)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.addTimer()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.stratTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.pauseTimer()
        
        if self.navigationController == nil {
            self.removeTimer()
        }
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? TotalCountCell else { fatalError("\(TotalCountCell.self)获取失败") }
        cell.selectionStyle = .none
        cell.model = self.dataArray[indexPath.row]
        return cell
    }
    
    // MARK: - Timer Config
    
    func addTimer() {
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
        self.timer = timer
    }
    
    func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
        NotificationCenter.default.removeObserver(self)
    }

    @objc func timerUpdate() {
        NotificationCenter.default.post(name: Notification.Name("CellUpdate"), object: Int(1))
    }
    
    /// 重启timer
    func stratTimer() {
        self.timer?.fireDate = Date.distantPast
    }
    
    /// 暂停timer
    func pauseTimer() {
        self.timer?.fireDate = Date.distantFuture
    }
    
    /// App 回到前台
    @objc private func appWillEnterForeground() {
        let timeIntervalCount = Int(CACurrentMediaTime() - self.recordTime)
        self.recordTime = 0
        NotificationCenter.default.post(name: Notification.Name("CellUpdate"), object: timeIntervalCount)
        self.stratTimer()
    }
    
    /// App 回到后台
    @objc private func appDidEnterBackground() {
        self.recordTime = CACurrentMediaTime()
    }

}
