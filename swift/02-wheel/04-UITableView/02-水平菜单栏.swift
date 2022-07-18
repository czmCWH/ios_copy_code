/*
 用 UITableView 实现侧边分段组件
 */


class ExpleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    var sheetView = KDApplyRefundSheetView()
    
    var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 70, height: 65)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(0xffffff)
        collectionView.register(ExampleCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(100)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }

    }

    // MARK: - UICollection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? ExampleCell else {
            fatalError("\(ExampleCell.self)获取失败" )
        }
        cell.titleLab.text = "第\(indexPath.item)个"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.reloadData()
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

class ExampleCell: UICollectionViewCell {
    var imgView: UIImageView!
    var titleBgView: UIView!
    var titleLab: UILabel!
    
    lazy var imgBorderLayer: CAShapeLayer = {
        let subLayer = CAShapeLayer()
        subLayer.fillColor = UIColor.clear.cgColor
        subLayer.strokeColor = UIColor(0x323CB0).cgColor
        subLayer.lineWidth = 1;
        return subLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(0xffffff)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // ⚠️⚠️⚠️：核心方法，改变Cell选中的样式
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.imgBorderLayer.isHidden = false
                self.titleBgView.isHidden = false
                self.titleLab.textColor = UIColor(0xFFFFFF)
            } else {
                self.imgBorderLayer.isHidden = true
                self.titleBgView.isHidden = true
                self.titleLab.textColor = UIColor(0x131313)
            }
        }
    }
    
    private func setupUI() {
        imgView = UIImageView()
        imgView.backgroundColor = UIColor(0xF2F2F2)
        self.contentView.addSubview(imgView)
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 35, height: 35), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let shapeLayer = (imgView.layer.mask as? CAShapeLayer) ?? CAShapeLayer()
        shapeLayer.path = path.cgPath
        imgView.layer.mask = shapeLayer
        
        self.imgBorderLayer.path = (imgView.layer.mask as? CAShapeLayer)?.path
        self.imgBorderLayer.isHidden = true
        imgView.layer.addSublayer(self.imgBorderLayer)
        
        titleBgView = UIView()
        titleBgView.backgroundColor = UIColor(0x3E42DD)
        titleBgView.layer.cornerRadius = 4
        titleBgView.isHidden = true
        self.contentView.addSubview(titleBgView)
        
        titleLab = UILabel()
        titleLab.font = UIFont.systemFont(ofSize: 13)
        titleLab.textColor = UIColor(0x131313)
        titleLab.textAlignment = .center
        self.contentView.addSubview(titleLab)
    }
    
    private func setupConstraints() {
        imgView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(35)
        }
        
        titleLab.snp.makeConstraints {
            $0.height.equalTo(17)
            $0.width.lessThanOrEqualTo(63)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        titleBgView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(titleLab)
            $0.height.equalTo(17)
        }
    }
}
        
