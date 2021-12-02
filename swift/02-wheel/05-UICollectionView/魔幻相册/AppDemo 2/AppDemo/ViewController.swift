//
//  ViewController.swift
//  AppDemo
//
//  Created by haozhongliang on 2021/5/8.
//

import UIKit
import Contacts
import ContactsUI

struct MyStruct {
    var size: CGSize?
    var orign: CGPoint?
    
}


class ViewController: UIViewController {

    var scrollView = UIScrollView()
    
    var beginX: CGFloat = 0.0
    var endX: CGFloat = 0.0
    
    var collection: UICollectionView!
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.clipsToBounds = false
        
        let width = view.frame.size.width

        let layout = CardCollectionLayout()
        layout.itemSize = .init(width: width-200, height: 300)
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 10


        collection = UICollectionView(frame: .init(x: 50, y: 300, width: width-100, height: 300), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
//        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        collection.backgroundColor = .orange
        view.addSubview(collection)
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.beginX = scrollView.contentOffset.x
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.endX = scrollView.contentOffset.x

        DispatchQueue.main.async { [self] in
            scrollViewScrollEnd()
        }
    }

    func scrollViewScrollEnd() {
        //最小滚动距离
        let dragMinDistance = self.collection.bounds.size.width/20.0

        if (beginX - endX >= dragMinDistance) {
            currentIndex -= 1; //向右
        }else if (endX - beginX >= dragMinDistance){
            currentIndex += 1 ;//向左
        }

        let maxIndex  = collection.numberOfItems(inSection: 0) - 1
        currentIndex = currentIndex <= 0 ? 0 :currentIndex
        currentIndex = currentIndex >= maxIndex ? maxIndex : currentIndex

        collection.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)

    }
}


// 基础控件实现卡片
extension ViewController: UIScrollViewDelegate {
    
     func creatCardView() {
        let contentView = UIView(frame: .init(x: 0, y: 300, width: view.frame.size.width-100, height: 100))
        contentView.backgroundColor = .orange
        
        scrollView.delegate = self
        scrollView.frame = contentView.bounds
        scrollView.isPagingEnabled = true
        scrollView.clipsToBounds = false

        for index in 0...3 {
            let view = UIView()
            view.backgroundColor = .randomColor
            scrollView.addSubview(view)
            
            let offsetY: CGFloat = index == 0 ? 0 : 15
            
            view.frame = CGRect(x: 15 + scrollView.frame.size.width * CGFloat(index), y: offsetY, width: scrollView.frame.size.width - 30, height: scrollView.frame.size.height-2*offsetY)
            
            view.tag = 100+index
        }

        scrollView.contentSize = .init(width: contentView.frame.size.width*4, height: 100)

        contentView.addSubview(scrollView)

        view.addSubview(contentView)
    }
/*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let contentOffsetX = scrollView.contentOffset.x
        let index = Int(contentOffsetX/scrollView.frame.size.width)

        if index > scrollView.subviews.count - 1 {
            return
        }

        // 左滑
        let bigView = scrollView.subviews[index]

        let offsetX = contentOffsetX - CGFloat(index) * scrollView.frame.size.width
        var offsetY = 15*offsetX/scrollView.frame.size.width
        offsetY = offsetY>0.0 ? offsetY : 0.0

        bigView.frame = CGRect(x: bigView.frame.origin.x, y: offsetY, width: bigView.frame.size.width, height: scrollView.frame.size.height-2*offsetY)

        let nextView = scrollView.subviews[index+1]
        if nextView.isMember(of: UIView.self) {
            nextView.frame = CGRect(x: nextView.frame.origin.x, y: 15-offsetY, width: bigView.frame.size.width, height: scrollView.frame.size.height-2*(15-offsetY))
        }
    }
 */
}
