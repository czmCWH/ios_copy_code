//
//  NextViewController.swift
//  test01
//
//  Created by michael on 2021/6/25.
//

import UIKit
import WebKit

class NextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "next"
        self.view.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        // 网格视图的滚动方向，默认值为 .vertical
        flowLayout.scrollDirection = .vertical
        // 每一个 item 的大小
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        // 最小行间距，默认值为 10.0；对于垂直滚动，表示连续行之间的最小间距。对于水平滚动，此值表示连续列之间的最小间距。
        flowLayout.minimumLineSpacing = 15
        // 同一行中 item 之间最小间距。对于垂直，表示同一行中item之间间距；对于水平，表示同一列中item之间的最小间距
        flowLayout.minimumInteritemSpacing = 24
        // section headers 的默认大小，默认值为 (0, 0)
        flowLayout.headerReferenceSize = .zero
        // 滚动时，section headers 是否固定到顶部，默认false不固定
        flowLayout.sectionHeadersPinToVisibleBounds = false
        // 每一组的内边距，默认值为.zero。
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(0xFFFFFF)
        /// 即使内容小于可显示的边界，也允许垂直拖动。即拖动反弹效果
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        collectionView.register(ZMCollectionViewCell.self, forCellWithReuseIdentifier: ZMCollectionViewCell.reuseIdentifier)
        collectionView.register(ZMCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension NextViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZMCollectionViewCell.reuseIdentifier, for: indexPath) as? ZMCollectionViewCell else {
            fatalError("\(ZMCollectionViewCell.self)获取失败" )
        }
        cell.titleLabel.text = "第\(indexPath.item)个Item"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! ZMCollectionHeaderView
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// 如果未实现该协议，则 UICollectionViewFlowLayout 则使用自身属性来布局

extension NextViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 100, left: 10, bottom: 100, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .zero
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .zero
    }
}




// MARK: - UICollectionViewCell
class ZMCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ZMCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            titleLabel.backgroundColor = isSelected ? UIColor(0xFFF5DE) : UIColor(0xF5F5F5)
        }
    }
    
    var titleLabel: UILabel!
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = self.bounds
    }
    
}


// MARK: - UICollectionReusableView

class ZMCollectionHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
