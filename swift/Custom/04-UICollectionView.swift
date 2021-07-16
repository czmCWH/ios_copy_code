 UICollectionView 的自定义布局 /// https://toutiao.io/posts/4k1ebb/preview
 iOS开发之UI篇（11）—— UICollectionView
 https://www.jianshu.com/p/d325510512fa


{
    let flowLayout = UICollectionViewFlowLayout()
    
    // 设置滚动方向
    flowLayout.scrollDirection = .vertical
    
    // 设置Cell的默认大小
    flowLayout.itemSize = CGSize(width: 100, height: 100)
    
    /**
     每一行之间最小间距，默认值为10.0，只适用于行与行之间，不包括页眉和第一行或最后一行和页脚。
     对于水平滚动的，它表示列之间间距；对于垂直滚动，表示行之间。
    */
    flowLayout.minimumLineSpacing = 5
    
    /**
     表示同一行cell之间的最小间距，默认值10.0，此间距用于计算一行中可以容纳的项目数，但在确定项目数后，实际间距可能会向上调整。
     对于水平滚动，它表示同一列cell之间的间隔；对于垂直滚动，它表示同一行cell之间的间隔。
     */
    flowLayout.minimumInteritemSpacing = 5
    
    /*
     用这个边距布局每组的内容。
     边距影响页眉视图的初始位置、每行项目两侧的最小空间以及从最后一行到页脚视图的距离。 边距插入不影响页眉和页脚视图在非滚动方向上的大小。
     默认值为.zero
     */
    flowLayout.sectionInset = .zero
    
    // 组头的默认大小
    flowLayout.headerReferenceSize = .zero
    // 组尾的默认大小
    flowLayout.footerReferenceSize = .zero
}

{
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
    /// 即使内容小于可显示的边界，也允许垂直拖动。即拖动反弹效果
    collectionView.alwaysBounceVertical = true
    /// 是否启用 scrollView 的分页效果
    collectionView.isPagingEnabled = false
    collectionView.delegate = self
    collectionView.dataSource = self
    if #available(iOS 11.0, *) {
        collectionView.contentInsetAdjustmentBehavior = .never;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    collectionView.register(ExampleCollectionViewCell.self, forCellWithReuseIdentifier: ExampleCollectionViewCell.reuseIdentifier)
    collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeader")
    collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
    self.view.addSubview(collectionView)
}


UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionViewCell.reuseIdentifier, for: indexPath) as? ExampleCollectionViewCell else {
            fatalError("\(ExampleCollectionViewCell.self)获取失败" )
        }
        
        cell.backgroundColor = .red
        return cell
    }
    
    // 设置 Collection View 的组头、组尾
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ExampleCollectionHeadReusableView.reuseIdentifier, for: indexPath) as! ExampleCollectionHeadReusableView
            
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            return footerView
        }
    }
    
    // 点击Cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
}

// UICollectionViewDelegateFlowLayout
{
    
    // cell 的 size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
    }
    
    // 每一组内容的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
    }
    
    // 每一行之间的最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
    }
    
    // 同一行cell之间的最小间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
    }
    
    // 组头size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
    }
    
    // 组尾size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
    }
}


class ExampleCollectionHeadReusableView: UICollectionReusableView {
    static let reuseIdentifier = "ExampleCollectionHeadReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func setupUI() {
    
    }
    
}
