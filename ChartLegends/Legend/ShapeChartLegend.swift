//
//  ShapeChartLegend.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public enum ChartLegendShape {
    
    case circle(radius: CGFloat)
    case rect(width: CGFloat, height: CGFloat)
}

public protocol ShapeChartLegend: ChartLegend {
    
    var shape: ChartLegendShape {get}
    
    var pathGenerator: ((CGSize) -> UIBezierPath)? {get set}
}
