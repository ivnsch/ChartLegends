//
//  LeftAlignedCollectionViewFlowLayout.swift
//  SwiftChartLegends
//
//  Created by Ivan Schuetz on 28/12/2016.
//  Copyright © 2016 Ivan Schuetz. All rights reserved.
//

import UIKit

// Src: http://stackoverflow.com/a/36016798/930450 (modified)
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        if let attributes = attributes {
            for attribute in attributes {
                if attribute.frame.origin.y >= maxY - 10 {
                    leftMargin = sectionInset.left
                }
                
                attribute.frame.origin.x = leftMargin
                
                leftMargin += attribute.frame.width + minimumInteritemSpacing
                maxY = max(attribute.frame.maxY , maxY)
            }
        }
        
        return attributes
    }
}
