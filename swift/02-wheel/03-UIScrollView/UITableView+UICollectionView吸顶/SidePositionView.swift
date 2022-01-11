
import UIKit

/// 装修侧边垂直定位索引跳转 View
class SidePositionView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var stackView: UIStackView!
    /// 折叠按钮
    var foldBtn: UIButton!
    /// 索引列表
    var tableView: UITableView!

    /// 当前选中的索引
    var currentIndex: IndexPath? {
        didSet {
            self.tableView.reloadData()
            self.tableView.selectRow(at: currentIndex, animated: true, scrollPosition: .middle)
        }
    }
    
    var clickItemClosure: ((Int) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        self.addSubview(stackView)
        
        foldBtn = UIButton(type: .custom)
        foldBtn.backgroundColor = .orange
        foldBtn.addTarget(self, action: #selector(clickFoldAction(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(foldBtn)
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.scrollsToTop = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SidePositionCell.self, forCellReuseIdentifier: SidePositionCell.reuseIdentifier)
        stackView.addArrangedSubview(tableView)
    }
    
    private func setupConstraints() {
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        foldBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 45, height: 35))
        }
        
        tableView.snp.makeConstraints {
            $0.width.equalTo(55)
            $0.height.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        27
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SidePositionCell.reuseIdentifier, for: indexPath) as? SidePositionCell else { fatalError("\(SidePositionCell.self)获取失败") }
        cell.selectionStyle = .none
        cell.titleLabel.text = "第\(indexPath.row)行"
        if let currentIndex = currentIndex {
            cell.titleLabel.textColor = indexPath == currentIndex ? .red : .black
        } else {
            cell.titleLabel.textColor = .black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        self.clickItemClosure?(indexPath.row)
    }
    
    @objc private func clickFoldAction(_ btn: UIButton) {
        if btn.isSelected {
            self.tableView.isHidden = false
            foldBtn.isSelected = false
        } else {
            self.tableView.isHidden = true
            foldBtn.isSelected = true
        }
    }
    
}
