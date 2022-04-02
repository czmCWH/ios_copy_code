//
//  ViewController.swift
//  DragCollectionCell
//
//  Created by czm on 2022/3/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var deleteLabel: UILabel!
    
    var dataArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var selectIdxPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        // 网格视图的滚动方向，默认值为 .vertical
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        flowLayout.minimumLineSpacing = 15
        let itmeSpace = (UIScreen.main.bounds.size.width - 80*4 - 20)/3
        flowLayout.minimumInteritemSpacing = itmeSpace
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "PhotoItemCell")
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:))))

        deleteLabel = UILabel()
        deleteLabel.isHidden = true
        deleteLabel.textAlignment = .center
        deleteLabel.text = "删除"
        deleteLabel.font = UIFont.systemFont(ofSize: 15)
        deleteLabel.textColor = UIColor.black
        deleteLabel.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        self.view.addSubview(deleteLabel)
        deleteLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(88)
        }   
    }
    
    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            self.selectIdxPath = nil
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else { return }
            if selectedIndexPath.section != 1 { return }
            if selectIdxPath == IndexPath(item: 9, section: 1) { return }
            self.deleteLabel.isHidden = false
            // 开始交互
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            let point = gesture.location(in: gesture.view!)
            // 更新位置
            collectionView.updateInteractiveMovementTargetPosition(point)
        case .ended:
            // 结束交互
            let point = gesture.location(in: self.deleteLabel)
            if point.x > 0 && point.y > 0 {
                guard let selectIdxPath = selectIdxPath else {
                    collectionView.cancelInteractiveMovement()
                    return
                }
                collectionView.cancelInteractiveMovement()

                dataArray.remove(at: selectIdxPath.item)
                self.collectionView.reloadSections(IndexSet([1]))
            } else {
                collectionView.endInteractiveMovement()
            }
            self.deleteLabel.isHidden = true
        default:
            // 默认取消交互
            collectionView.cancelInteractiveMovement()
            self.deleteLabel.isHidden = true
        }
    }


    func texts() {
        let dataCount = dataArray.count + 1
        let surplus = dataCount%4
        let row = dataCount/4 + (dataCount%4 == 0 ? 0 : 1)
//        print("===czm===", count, surplus)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? dataArray.count + 1 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoItemCell", for: indexPath) as? PhotoItemCell else {
            fatalError("\(PhotoItemCell.self)获取失败" )
        }
        
        switch indexPath.section {
        case 1:
            cell.backgroundColor = UIColor.orange
            if indexPath.item < dataArray.count {
                cell.titleLabel.text = "\(self.dataArray[indexPath.item])"
            } else {
                cell.titleLabel.text = "添加"
            }
            
        default:
            cell.titleLabel.text = "其它"
            cell.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        }
        
        return cell
    }
    
    // 询问 collectionView.dataSource 是否可以将指定的项移动到集合视图中的其他位置
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        // 只允许移动 section == 1 组内的，且不是最后一个cell
        if indexPath.section != 1 {
            return false
        } else {
            return indexPath.item != self.dataArray.count
        }
    }
    
    /* 必须在此方法中更新我们自己的数据源
     sourceIndexPath：原始索引
     destinationIndexPath：目标索引
     */
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let number = dataArray.remove(at: sourceIndexPath.item)
        dataArray.insert(number, at: destinationIndexPath.item)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    
    /* 在移动cell过程中，使用该方法返回的索引，将cell放在该索引对应的位置。可以使用此方法来防止用户将item放到无效位置
     currentIndexPath：cell 原始索引路径
     proposedIndexPath：建议 cell放置的位置
     */
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt currentIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        // 如果移动cell不在 section == 1
        if proposedIndexPath.section != 1 {
            self.selectIdxPath = currentIndexPath
            return currentIndexPath
        } else {
            let idx = proposedIndexPath.item == self.dataArray.count ? currentIndexPath : proposedIndexPath
            self.selectIdxPath = idx
            return idx
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        if indexPath == IndexPath(item: self.dataArray.count, section: 1) {
            let maxValue = self.dataArray.max() ?? 0
            self.dataArray.append(maxValue + 1)
            self.collectionView.reloadSections(IndexSet([1]))
        }
    }

    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            return CGSize(width: 80, height: 80)
        default:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 1:
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 15
        default:
            return 0
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return (UIScreen.main.bounds.size.width - 80*4 - 20)/3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .zero
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        .zero
    }
}
