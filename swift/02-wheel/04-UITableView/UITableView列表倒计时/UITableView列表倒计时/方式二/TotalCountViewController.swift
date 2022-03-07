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
    var countDownArray: [CountDownModel] = []
    
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
            self.countDownArray = self.dataArray.filter { $0.num > 0 }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.addTimer()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        
    }
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    weak var timer: Timer?
    var timeIntervalCount: Int = 0
    var endTime: Date?
    
    /// 添加倒计时
    /// - Parameter seconds: 总秒数
    private func addTimer() {
        removeTimer()
        
//        let endTime = Date(timeIntervalSinceNow: TimeInterval(seconds))
        
        let tmpTimer = Timer(timeInterval: 1, repeats: true) { [weak self] (t) in
            if let endTime = self?.endTime {
                let interval = endTime.timeIntervalSinceNow
                let integerCount = Int(ceil(interval))
                self?.timeIntervalCount -= integerCount
            } else {
                self?.timeIntervalCount += 1
            }
            self?.updateCells()
            
        }
        RunLoop.current.add(tmpTimer, forMode: .common)
        tmpTimer.fire()
        timer = tmpTimer
    }
    
    
    private func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func updateCells() {
        for cell in self.tableView.visibleCells {
            guard let index = self.tableView.indexPath(for: cell) else {
                break
            }
            let model = self.dataArray[index.row]
            let num = max(0, model.num - self.timeIntervalCount)
            (cell as? TotalCountCell)?.rightLabel.text = "可变数量：\(num)"
        }
    }
    
    
    @objc func appWillResignActive() {
        print("====app退到后台")
        self.endTime = Date()
    }
    
    @objc func appDidBecomeActive() {
        print("====app回到前台")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? TotalCountCell else { fatalError("\(TotalCountCell.self)获取失败") }
        cell.selectionStyle = .none
        let model = self.dataArray[indexPath.row]
        cell.leftLabel.text = "第\(model.idx)行"
        cell.rightLabel.text = "可变数量：\(model.num)"
        cell.backgroundColor = .white
        return cell
    }
    
    

}
