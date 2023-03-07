//
//  CircularCollectionViewLayout.swift
//  wheelPicker
//
//  Created by katya on 6.03.23.
//

import UIKit

class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}

class CircularCollectionViewLayout: UICollectionViewLayout {
    
    let itemSize = CGSize(width: 100, height: 120)
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
        -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width -
                                                                   collectionView!.bounds.width)
    }
    
    var radius: CGFloat = 300 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    
    var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width,
                      height: collectionView!.bounds.height)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    override func prepare() {
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width / 2.0)
        let anchorPointY = ((itemSize.height / 3.0) + radius) / itemSize.height
        
        let theta = atan2(collectionView!.bounds.width / 2.0,
                          radius + (itemSize.height / 2.0) - (collectionView!.bounds.height / 2.0))
        
        var startIndex = 0
        var endIndex = collectionView!.numberOfItems(inSection: 0) - 1
        
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))
        
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
        
        attributesList = (startIndex...endIndex).map { (i) -> CircularCollectionViewLayoutAttributes in
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: collectionView!.bounds.midY + 200)
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList.filter { rect.intersects($0.frame) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.row < attributesList.count else {
            return nil
        }
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
