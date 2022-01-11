
// 参考博客：https://juejin.cn/post/6844903734586277895

/*
 
 谷歌搜索滚动到特定的Cell: ios开发获取UICollectionViewCell的frame
 
 https://www.jianshu.com/p/9f51a4a2d5f2?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 */


import UIKit
import EachNavigationBar

class CollectViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var rightView: KDDecorateSidePositionView!
    
    lazy var cellHeightArray: [CGFloat] = {
        var arr: [CGFloat] = []
        for _ in 0..<25 {
            arr.append(CGFloat(Int.random(in: 50...150)))
        }
        return arr
    }()
    
    /// 右侧导航栏定位的索引：key表示主列表的 indexPath.item；value 表示右侧导航栏的索引
    private var dict = [3: 0, 5: 1, 7: 2, 9: 3, 13: 4, 18: 5, 22: 6]
    
    /// 是否正在点击选择索引
    var isTapSelectIndex = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navigation.item.title = "Collect VC"
        self.navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.black]

        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        // true：表示滚动时把 section header 吸顶
        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(0xFFFFFF)
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ZMCollectionViewCell.self, forCellWithReuseIdentifier: ZMCollectionViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        rightView = KDDecorateSidePositionView()
        rightView.clickItemClosure = { idx in
            if let idx = self.dict.filter({ $0.1 == idx }).map({ (key, value) in key }).first {
                self.isTapSelectIndex = true
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: idx), at: .top, animated: true)
            }
        }
        self.view.addSubview(rightView)
        
        rightView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview().offset(32)
            $0.height.equalTo(300)
        }
    }
    
}

// MARK: - Scroll View Delegate 核心代码
extension CollectViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isTapSelectIndex { return }
        
        let selIndx = collectionView.indexPathForItem(at: scrollView.contentOffset)
        if let selIndx = selIndx {
            if let row = dict[selIndx.section + 1] {
                self.rightView.currentIndex = IndexPath(row: row, section: 0)
            } else {
                self.rightView.currentIndex = nil
            }
        } else {
            self.rightView.currentIndex = nil
            self.rightView.tableView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTapSelectIndex = false
    }
}


// MARK: - Delegate

extension CollectViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource, UICollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 25 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZMCollectionViewCell.reuseIdentifier, for: indexPath) as? ZMCollectionViewCell else {
            fatalError("\(ZMCollectionViewCell.self)获取失败" )
        }
        if let row = self.dict[indexPath.section] {
            cell.titleLabel.text = "第\(indexPath.section)个Item-----对应右侧索引\(row)"
        } else {
            cell.titleLabel.text = "第\(indexPath.section)个Item"
        }
        cell.backgroundColor = indexPath.section % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: self.cellHeightArray[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


// MARK: - UICollectionViewCell
class ZMCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ZMCollectionViewCell"
    
//    override var isSelected: Bool {
//        didSet {
//            titleLabel.backgroundColor = isSelected ? UIColor(0xFFF5DE) : UIColor(0xF5F5F5)
//        }
//    }
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .red
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }
    
}
