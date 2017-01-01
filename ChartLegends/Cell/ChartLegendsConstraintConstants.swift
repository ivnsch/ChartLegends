//
//  ChartLegendsConstraintConstants.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 03/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public protocol ChartLegendsConstraintConstants {
    var staticSize: CGSize {get}
}

public struct ZeroChartLegendsConstraintConstants: ChartLegendsConstraintConstants {
    public var staticSize: CGSize = CGSize.zero
}
