
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
if #available(iOS 15.0, *) {
    tableView.sectionHeaderTopPadding = 0
    tableView.isPrefetchingEnabled = true
}
if #available(iOS 11.0, *) {
    tableView.contentInsetAdjustmentBehavior = .never
}
tableView.separatorStyle = .none
tableView.scrollsToTop = false
tableView.dataSource = self
tableView.delegate = self
tableView.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.reuseIdentifier)
self.view.addSubview(tableView)

/*
 当 tableView 顶部出现留空白问题时，注意排查下 有设置 tableHeaderView 和 tableFooterView，footer和header只要设置了任意一个都会使两个地方都出现空白，所以一般都不设置。
 
 具体可参考博客：https://blog.csdn.net/knaht/article/details/81814609
 */

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

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
}

func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
}

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    0.000001
}

func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    0.000001
}
