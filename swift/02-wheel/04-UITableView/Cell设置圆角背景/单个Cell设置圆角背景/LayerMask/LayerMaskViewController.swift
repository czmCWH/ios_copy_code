// 参考博客：https://juejin.cn/post/6844903891901874190

import UIKit

class LayerMaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let sectionRowArray = [1, 3, 2, 5, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 50
        tableView.estimatedRowHeight = 50.0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LayerMaskTableViewCell.self, forCellReuseIdentifier: "cellID")
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.sectionRowArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sectionRowArray[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? LayerMaskTableViewCell else { fatalError("\(LayerMaskTableViewCell.self)获取失败") }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        let rowCount = self.sectionRowArray[indexPath.section]
        if rowCount == 1 {
            cell.position = .solo
            cell.textLabel?.text = "单个Cell"
        } else {
            switch indexPath.row {
            case 0:
                cell.position = .first
                cell.textLabel?.text = "第一个Cell"
            case rowCount - 1:
                cell.position = .last
                cell.textLabel?.text = "末尾Cell"
            default:
                cell.textLabel?.text = "中间Cell"
                cell.position = .middle
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.000001
    }
    



}
