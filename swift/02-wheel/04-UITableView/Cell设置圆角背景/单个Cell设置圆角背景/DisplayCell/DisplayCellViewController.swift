
// 参考博客：https://www.jianshu.com/p/dd6f23d3eac8
// https://blog.csdn.net/wwww11519/article/details/81480863

import UIKit

class DisplayCellViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        tableView.register(DisplayViewCell.self, forCellReuseIdentifier: "cellID")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? DisplayViewCell else { fatalError("\(LayerMaskTableViewCell.self)获取失败") }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        let rowCount = self.sectionRowArray[indexPath.section]
        if rowCount == 1 {
//            cell.position = .solo
            cell.textLabel?.text = "单个Cell"
        } else {
            switch indexPath.row {
            case 0:
//                cell.position = .first
                cell.textLabel?.text = "第一个Cell"
            case rowCount - 1:
//                cell.position = .last
                cell.textLabel?.text = "末尾Cell"
            default:
                cell.textLabel?.text = "中间Cell"
//                cell.position = .middle
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rowsCount = tableView.numberOfRows(inSection: indexPath.section)
        let corners: UIRectCorner
        switch rowsCount {
        case 1:
            corners = .allCorners
        default:
            switch indexPath.row {
            case 0:
                corners = [.topLeft, .topRight]
            case rowsCount - 1:
                corners = [.bottomLeft, .bottomRight]
            default:
                corners = []
            }
        }
        
        let rect = CGRect(x: 13, y: 0, width: cell.bounds.size.width - 25, height: cell.bounds.size.height)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 8, height: 8))
        let shapLayer = CAShapeLayer()
        shapLayer.path = path.cgPath
        
        let cellBgView = UIView(frame: cell.bounds)
        cellBgView.backgroundColor = UIColor.white
        cellBgView.layer.mask = shapLayer
        cell.backgroundView = cellBgView
    }

}
