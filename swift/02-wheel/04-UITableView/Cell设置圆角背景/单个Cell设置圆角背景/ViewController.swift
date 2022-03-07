
import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let cellTitlesArray = ["添加 cell 背景View.clipsToBounds",
                           "每个 Cell 添加 CAShapeLayer mask 实现 section cell 的圆角",
                           "为即将显示的Cell backgroundView 设置 ayer mask 实现 section cell 的圆角",
                           "对单个 cell 的背景图片 stretch 拉伸"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        tableView.backgroundColor = UIColor.white
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.blue
        tableView.rowHeight = 55
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitlesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        cell.textLabel?.text = self.cellTitlesArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = ClipViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = LayerMaskViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = DisplayCellViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = StretchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

