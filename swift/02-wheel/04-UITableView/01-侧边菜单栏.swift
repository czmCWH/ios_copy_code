/*
 用 UITableView 实现侧边分段组件
 
 参考博客：https://cloud.tencent.com/developer/article/1332165
 
 */


class ExpleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExampleCell.self, forCellReuseIdentifier: ExampleCell.reuseIdentifier)
        self.view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExampleCell.reuseIdentifier, for: indexPath) as? ExampleCell else { fatalError("\(ExampleCell.self)获取失败") }
        cell.label.text = "第\([indexPath.row])个"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        
    }
}

class ExampleCell: UITableViewCell {

    static let reuseIdentifier = "ExampleCell"
    
    var label: UILabel!
    
    // 用于控制背景图片悬浮起来
    var floatBgView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        
        floatBgView = UIView()
        floatBgView.backgroundColor = UIColor.white
        self.contentView.addSubview(floatBgView)
        floatBgView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(10)
        }
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        self.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // ⚠️⚠️⚠️：核心方法，在此处编写让选中 Cell 改变样式
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.backgroundColor = UIColor(0xFFFFFF)
            label.textColor = UIColor.black
            floatBgView.isHidden = false
            self.contentView.layer.zPosition = 0
        } else {
            self.backgroundColor = UIColor.gray
            label.textColor = UIColor.yellow
            floatBgView.isHidden = true
            self.contentView.layer.zPosition = 1
        }
    }
}

