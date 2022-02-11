
import UIKit

// UICollectionViewDelegateFlowLayout

class NextNViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "next_new"
        self.view.backgroundColor = .white
    
//        let flowLayout = UICollectionViewFlowLayout()
        let flowLayout = RowStyleLayout()
        flowLayout.scrollDirection = .horizontal
        let widt = (UIScreen.main.bounds.size.width - 30) / 3
        flowLayout.itemSize = CGSize(width: widt, height: 150)
        flowLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardItemViewCell.self, forCellWithReuseIdentifier: CardItemViewCell.reuseIdentifier)
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(200)
        }
        
        createActionBtn()
        
//        (collectionView.collectionViewLayout as? RowStyleLayout)?.itemSize
    }
    
    
    // MARK: - Actions
    
    func createActionBtn() {
        let btn1 = UIButton()
        btn1.backgroundColor = UIColor.red
        btn1.addTarget(self, action: #selector(clickBtn1(_:)), for: .touchUpInside)

        let btn2 = UIButton()
        btn2.backgroundColor = UIColor.green
        btn2.addTarget(self, action: #selector(clickBtn2(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [btn1, btn2])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 35
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(30)
            $0.size.equalTo(CGSize(width: 200, height: 45))
        }
        
    }

    /// 减，往右滑
    @objc func clickBtn1(_ btn: UIButton) {
        
        let offsetPoint = CGPoint(x: collectionView.contentOffset.x + 20, y: 30)
        guard let leftItemIdxPath = self.collectionView.indexPathForItem(at: offsetPoint) else { return }
        if leftItemIdxPath.row == 0 { return }
        let nextIndexPath = IndexPath(row: leftItemIdxPath.row - 1, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
    }
    
    /// 加，往左滑
    @objc func clickBtn2(_ btn: UIButton) {let offX = collectionView.contentOffset.x + collectionView.frame.size.width - 20
        let offsetPoint = CGPoint(x: offX, y: 30)
        guard let lastIndexPath = self.collectionView.indexPathForItem(at: offsetPoint) else { return }
        let rowCount = collectionView.numberOfItems(inSection: 0)
        if lastIndexPath.row + 1 == rowCount { return }
        let nextIndexPath = IndexPath(row: lastIndexPath.row + 1, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .right, animated: true)
    }

 
   // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardItemViewCell.reuseIdentifier, for: indexPath) as? CardItemViewCell else {
            fatalError("\(CardItemViewCell.self)获取失败" )
        }
        cell.titleLabel.text = "第\(indexPath.item + 1)个Item"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewCell
class CardItemViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CardItemViewCell"
    
    var titleLabel: UILabel!
    
    var vLineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
        vLineView = UIView()
        vLineView.backgroundColor = .yellow
        self.contentView.addSubview(vLineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
        
        vLineView.frame = CGRect(x: 0, y: 0, width: 1, height: self.bounds.size.height)
    }
    
}
