//
//  ShopItemView.swift
//  test01
//
//  Created by michael on 2021/6/19.
//
/* 使用方式：
 
 let shopItemView = ShopItemView()
 view.addSubview(shopItemView)
 
 shopItemView.snp.makeConstraints {
     
     if #available(iOS 11.0, *) {
         $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
     } else {
         $0.top.equalTo(self.topLayoutGuide.snp.top).offset(40)
     }
     $0.leading.bottom.equalToSuperview()
     $0.width.equalTo(105)
     if #available(iOS 11.0, *) {
         $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
     } else {
         $0.bottom.equalToSuperview().offset(-10)
     }
 }
 
 */

import UIKit
import SnapKit

/// 防京东侧边菜单选择器，带圆角选择器
class BorderMenuView: UIView {
    
    var collectionView: UICollectionView!
    var selectedIndex: NSInteger = 0
    var dataCount = 20

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.itemSize = CGSize(width: 105, height: 55)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = true
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .gray
        collectionView.register(ShopItemViewCell.self, forCellWithReuseIdentifier: ShopItemViewCell.reuseIdentifier)
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension BorderMenuView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCount + 1
//        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopItemViewCell.reuseIdentifier, for: indexPath) as? ShopItemViewCell  else { fatalError("\(ShopItemViewCell.self)获取失败") }
        switch indexPath.item {
        case self.selectedIndex:
            cell.roundCornersType = .topBottomRight
        case (self.selectedIndex - 1):
            cell.roundCornersType = .bottomRight
        case (self.selectedIndex + 1):
            cell.roundCornersType = .topRight
        default:
            cell.roundCornersType = .normal
        }
//        if indexPath.item == {
//            <#code#>
//        }
        cell.label.text = indexPath.item <= dataCount - 1 ? "产品-\(indexPath.item)" : nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == dataCount { return }
        let preSelectedIndex = self.selectedIndex
        self.selectedIndex = indexPath.item

        collectionView.reloadData()
        collectionView.selectItem(at: IndexPath(item: self.selectedIndex, section: 0), animated: true, scrollPosition: [])
        

        return
        
        var indexArr: [IndexPath] = []
        if preSelectedIndex - 1 >= 0 {
            let gpOneIndexOne = IndexPath(item: preSelectedIndex - 1, section: 0)
            indexArr.append(gpOneIndexOne)
        }
        let gpOneIndexTwo = IndexPath(item: preSelectedIndex, section: 0)
        indexArr.append(gpOneIndexTwo)
        let gpOneIndexThree = IndexPath(item: preSelectedIndex + 1, section: 0)
        indexArr.append(gpOneIndexThree)

        if selectedIndex - 1 >= 0 {
            let gpTwoIndexOne = IndexPath(item: selectedIndex - 1, section: 0)
            indexArr.append(gpTwoIndexOne)
        }

        let gpTwoIndexTwo = IndexPath(item: selectedIndex, section: 0)
        indexArr.append(gpTwoIndexTwo)
        let gpTwoIndexThree = IndexPath(item: selectedIndex + 1, section: 0)
        indexArr.append(gpTwoIndexThree)
        
        let results = indexArr.enumerated().filter { (index,value) -> Bool in
                    return indexArr.firstIndex(of: value) == index
                }.map {
                    $0.element
                }
        collectionView.reloadItems(at: results)
        collectionView.selectItem(at: IndexPath(item: self.selectedIndex, section: 0), animated: true, scrollPosition: [])
        
    }
}

// MARK: - UICollectionViewCell

class ShopItemViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ShopItemViewCell"
    
    enum ItemCornersType {
        case normal
        case topRight
        case bottomRight
        case topBottomRight
    }
    
    var topRightView: ShopItemCellBgView!
    var bottomRightView: ShopItemCellBgView!
    var label: UILabel!
    
    override var isSelected: Bool {
        didSet {
            label.font = isSelected ? UIFont.boldSystemFont(ofSize: 17) : UIFont.systemFont(ofSize: 17)
        }
    }
    
    var roundCornersType: ItemCornersType? {
        didSet {
            guard let cornersType = roundCornersType else { return }
            switch cornersType {
            case .normal:
                topRightView.isHidden = true
                bottomRightView.isHidden = true
                backgroundColor = .gray
            case .topRight:
                topRightView.isHidden = false
                bottomRightView.isHidden = true
                backgroundColor = .white
            case .bottomRight:
                topRightView.isHidden = true
                bottomRightView.isHidden = false
                backgroundColor = .white
            case .topBottomRight:
                topRightView.isHidden = true
                bottomRightView.isHidden = true
                backgroundColor = .white
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    private func setupUI() {
        
        topRightView = ShopItemCellBgView(true)
        bottomRightView = ShopItemCellBgView(false)
        addSubview(topRightView)
        addSubview(bottomRightView)
        
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
    }

    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topRightView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomRightView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

class ShopItemCellBgView: UIView {
    
    /// true：圆角在右上角，false：圆角在右下角
    let isRightTop: Bool
    
    init(_ rightTop: Bool) {
        isRightTop = rightTop
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: isRightTop ? .topRight : .bottomRight, cornerRadii: CGSize(width: 13, height: 13))
        maskPath.close()
        
        UIColor.gray.setFill()
        maskPath.fill()
    }
}
