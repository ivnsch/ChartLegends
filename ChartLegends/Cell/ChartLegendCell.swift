//
//  ChartLegendCell.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 03/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public protocol ChartLegendCell {
    
    var defaultFont: UIFont? {get set}
    
    static var defaultConstraintConstants: ChartLegendsConstraintConstants {get}
    
    func initConstraints(constants: ChartLegendsConstraintConstants)
}

extension ChartLegendCell {
    
    public static var defaultConstraintConstants: ChartLegendsConstraintConstants {
        return ZeroChartLegendsConstraintConstants()
    }
    
    public func initConstraints(constants: ChartLegendsConstraintConstants) {}
}
