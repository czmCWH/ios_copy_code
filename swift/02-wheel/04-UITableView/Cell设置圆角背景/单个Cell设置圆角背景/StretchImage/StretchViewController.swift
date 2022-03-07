
import UIKit

class StretchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView(frame: .zero, style: .plain)
    
    let cellHeightArray: [CGFloat] = [60, 150, 89, 130, 100, 80, 90, 70, 130]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        tableView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StretchTableViewCell.self, forCellReuseIdentifier: "cellID")
        self.view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellHeightArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? StretchTableViewCell else { fatalError("\(StretchTableViewCell.self)获取失败") }
//        cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .orange
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.cellHeightArray[indexPath.row]
    }

}
