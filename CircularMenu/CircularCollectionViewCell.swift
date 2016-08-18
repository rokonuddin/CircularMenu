//
//  CircularCollectionViewCell.swift
//  CircularMenu
//
//  Created by Admin on 8/18/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var imageName = "" {
        didSet {
            imageView!.image = UIImage(named: imageName)
        }
    }
    
    override func awakeFromNib() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.blackColor().CGColor
        contentView.layer.borderWidth = 1
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.mainScreen().scale
        contentView.clipsToBounds = true
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5)*CGRectGetHeight(self.bounds)
    }
    
    
    
}
