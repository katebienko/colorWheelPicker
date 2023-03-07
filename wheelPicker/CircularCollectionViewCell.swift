//
//  CircularCollectionViewCell.swift
//  wheelPicker
//
//  Created by katya on 5.03.23.
//

import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    //    contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 6
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with imageName: String) {
        myImageView.image = UIImage(named: imageName)
        myImageView.contentMode = .scaleAspectFill
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        guard let circularLayoutAttributes = layoutAttributes as? CircularCollectionViewLayoutAttributes
        else {
            return
        }
        
        self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
        self.center.y += (circularLayoutAttributes.anchorPoint.y - 0.1) * self.bounds.height
    }
}
