//
//  CGRect.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

extension CGRect {

    var center: CGPoint {
        return CGPoint(x: minX + width / 2, y: minY + height / 2)
    }
    
}
