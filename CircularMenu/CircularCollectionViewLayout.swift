//
//  CircularCollectionViewLayout.swift
//  CircularMenu
//
//  Created by Admin on 8/17/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class CircularCollectionViewLayout: UICollectionViewLayout {

    let itemSize = CGSize(width: 133, height: 173)
    
    var radius: CGFloat = 500 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItemsInSection(0) > 0 ? -CGFloat(collectionView!.numberOfItemsInSection(0)-1)*anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme*collectionView!.contentOffset.x/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
    }
    
    var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width,
                      height: CGRectGetHeight(collectionView!.bounds))
    }
    
    
    override class func layoutAttributesClass() -> AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds)/2.0)
        let anchorPointY = ((itemSize.height/2.0) + radius)/itemSize.height
        let theta = atan2(CGRectGetWidth(collectionView!.bounds)/2.0, radius + (itemSize.height/2.0) - (CGRectGetHeight(collectionView!.bounds)/2.0)) //1
        var startIndex = 0
        var endIndex = collectionView!.numberOfItemsInSection(0) - 1
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle)/anglePerItem))
        }
        endIndex = min(endIndex, Int(ceil((theta - angle)/anglePerItem)))
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
        attributesList = (startIndex...endIndex).map { (i) -> CircularCollectionViewLayoutAttributes in
            let attributes = CircularCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds))
            attributes.angle = -(self.angle + (self.anglePerItem*CGFloat(i)))
            attributes.anchorPoint = CGPoint(x: 0.5, y: -anchorPointY)
            return attributes
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
