
if #available(iOS 11.0, *) {
    UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
    UITableView.appearance().estimatedRowHeight = 0
    UITableView.appearance().estimatedSectionFooterHeight = 0
    UITableView.appearance().estimatedSectionHeaderHeight = 0
}


if #available(iOS 11.0, *) {
    tableView.contentInsetAdjustmentBehavior = .never
} else {
    self.automaticallyAdjustsScrollViewInsets = false
}

--------------------- plain ---------------------

let tableView = UITableView(frame: .zero, style: .plain)
tableView.backgroundColor = UIColor.white
tableView.tableHeaderView = UIView()
tableView.tableFooterView = UIView()
tableView.estimatedRowHeight = 50.0
tableView.separatorStyle = .none
tableView.scrollsToTop = false
tableView.dataSource = self
tableView.delegate = self
tableView.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.reuseIdentifier)
self.view.addSubview(tableView)
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.reuseIdentifier, for: indexPath) as? ExampleCell else { fatalError("\(ExampleCell.self)获取失败") }
    cell.selectionStyle = .none
    return cell
}
    
--------------------- grouped ---------------------

let tableView = UITableView(frame: .zero, style: .grouped)
tableView.backgroundColor = UIColor.white
tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
tableView.tableFooterView = UIView()
tableView.rowHeight = 50
tableView.estimatedRowHeight = 50.0
tableView.estimatedSectionFooterHeight = 0
tableView.estimatedSectionHeaderHeight = 0
tableView.separatorStyle = .none
tableView.scrollsToTop = false
tableView.dataSource = self
tableView.delegate = self
tableView.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.reuseIdentifier)
self.view.addSubview(tableView)

func numberOfSections(in tableView: UITableView) -> Int {
    3
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.reuseIdentifier, for: indexPath) as? ExampleCell else { fatalError("\(ExampleCell.self)获取失败") }
    cell.selectionStyle = .none
    return cell
}

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    0.000001
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    0.000001
}
