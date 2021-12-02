//
//  CardCollectionLayout.swift
//  AppDemo
//
//  Created by haozhongliang on 2021/5/10.
//

import UIKit

// 卡片布局
class CardCollectionLayout: UICollectionViewFlowLayout {


    // 卡片布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let elements = super.layoutAttributesForElements(in: rect) ?? []
        
        var arr = [UICollectionViewLayoutAttributes]()
        for itemAttributes in elements {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            arr.append(itemAttributesCopy)
        }
        
        // 屏幕中间x坐标
        let middleX = (self.collectionView?.contentOffset.x)! + ((self.collectionView?.bounds.size.width)!/2)
        
        for attribute in arr {
            let distance = abs(attribute.center.x - middleX)
            var scale = abs(1 - distance/(self.collectionView?.bounds.size.width)!)
            
            scale = scale < 0.8 ? 0.8: scale
            
            attribute.transform3D = CATransform3DMakeScale(scale, scale, 1.0)
            
            //透明度
            attribute.alpha = 1
        }
        return arr
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
 
    
    
}
