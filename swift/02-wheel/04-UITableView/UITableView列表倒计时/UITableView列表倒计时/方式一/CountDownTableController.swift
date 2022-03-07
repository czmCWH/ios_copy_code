/* 倒计时
 
 https://juejin.cn/post/6844903888697442317
 https://www.jianshu.com/p/68107e24710e
 
 */

import UIKit

class CountDownTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        tableView.register(CountDownCell.self, forCellReuseIdentifier: "CellID")
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
//                print("====减\(integerCount)秒", self?.tableView.visibleCells.count)
                self?.reduceCountActions(-integerCount)
            } else {
//                print("====减1秒", self?.tableView.visibleCells.count)
                self?.reduceCountActions(1)
                
            }
        }
        RunLoop.current.add(tmpTimer, forMode: .common)
        tmpTimer.fire()
        timer = tmpTimer
    }
    
    
    private func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func reduceCountActions(_ reduceValue: Int) {
        var removeModelArray = [CountDownModel]()
        for (idx, item) in self.dataArray.enumerated() {
            if item.num == 0 {
                item.num = 0
                removeModelArray.append(item)
                
            } else {
                let num = item.num - reduceValue
                if num <= 0 {
                    item.num = 0
                    removeModelArray.append(item)
                } else {
                    item.num = num
                }
            }
        }
        
        for cell in self.tableView.visibleCells {
            guard let index = self.tableView.indexPath(for: cell) else {
                break
            }
            let model = self.dataArray[index.row]
            (cell as? CountDownCell)?.rightLabel.text = "可变数量：\(model.num)"
        }
        
        
        for item in removeModelArray {
            if let idx = self.dataArray.firstIndex(of: item) {
                self.dataArray.remove(at: idx)
                
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [IndexPath(row: idx, section: 0)], with: .none)
                self.tableView.endUpdates()
            }
            
        }
        self.tableView.reloadData()
        
        // 移除某个cell
//        for i in idxPathArray {
//            self.dataArray.remove(at: i.row)
//        }
//        self.tableView.beginUpdates()
//        self.tableView.deleteRows(at: idxPathArray, with: .none)
//        self.tableView.endUpdates()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? CountDownCell else { fatalError("\(CountDownCell.self)获取失败") }
        cell.selectionStyle = .none
        let model = self.dataArray[indexPath.row]
        cell.leftLabel.text = "第\(model.idx)行"
        cell.rightLabel.text = "可变数量：\(model.num)"
        cell.backgroundColor = .white
        return cell
    }
    
    

}
