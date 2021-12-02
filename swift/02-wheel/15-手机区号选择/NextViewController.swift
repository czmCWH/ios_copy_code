
import UIKit
import HandyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var dataArray: [KDCountryCodeListModel] = {
        guard let path = Bundle.main.path(forResource: "CountryCode", ofType: "json") else {
            return []
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else { return [] }
        
        guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers), let jsonArr = jsonData as? Array<[String: Any]> else { return [] }
        
        guard let dataList = [KDCountryCodeListModel].deserialize(from: jsonArr) else { return [] }
        
        // 对数组中的可选类型进行可选解包，并且去掉空数据
        let dataArr = dataList.compactMap { $0 }.filter { $0.countryList.count > 0 }
        return dataArr
    }()
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "next"
        self.view.backgroundColor = .white
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(0xf5f5f5)
        tableView.rowHeight = 55
        tableView.backgroundColor = UIColor(0xffffff)
        tableView.sectionIndexColor = UIColor(0x404040)
        tableView.register(KDCountryCodeCell.self, forCellReuseIdentifier: KDCountryCodeCell.reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataArray[section].countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KDCountryCodeCell.reuseIdentifier, for: indexPath) as? KDCountryCodeCell else { fatalError("\(KDCountryCodeCell.self)获取失败") }
        cell.model = self.dataArray[indexPath.section].countryList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArray[indexPath.section].countryList[indexPath.row]
        print("===czm===", model.countryName)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = UIColor(0xf5f5f5)
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.textColor = UIColor(0x404040)
        lab.textAlignment = .left
        lab.text = self.dataArray[section].key
        sectionView.addSubview(lab)
        lab.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 32.0 }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0.0000001 }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let titles = self.dataArray.map { item in
            return item.key
        }
        return titles
    }
    
}
