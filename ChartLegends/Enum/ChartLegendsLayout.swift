//
//  ChartLegendsLayout.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public enum ChartLegendsLayout {
    
    case flow
    case flowLeft
    case columns(Int)
    
    var typeString: String {
        switch self {
        case .flow: return "flow"
        case .flowLeft: return "flowLeft"
        case .columns(_): return "columns"
        }
    }
}
