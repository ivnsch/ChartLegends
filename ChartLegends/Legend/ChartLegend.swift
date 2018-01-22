//
//  ChartLegend.swift
//  SwiftChartLegends
//
//  Created by Ivan Schuetz on 01/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public protocol ChartLegend {

    var text: String {get}
    var color: UIColor {get}
    var font: UIFont? {get} // Overrides default font
    
    func contentSize(font: UIFont) -> CGSize
}

extension ChartLegend {
    
    public func contentSize(font: UIFont) -> CGSize {
        return (text as NSString).size(withAttributes: [.font: font])
    }
}
