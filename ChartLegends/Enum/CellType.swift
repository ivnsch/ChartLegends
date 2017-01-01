//
//  CellType.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public enum CellType {
    case plainText
    case shapeText
    case custom(CellTypeWrapper)
    
    public var type: UICollectionViewCell.Type {
        switch self {
        case .plainText: return TextLabelChartLegendCell.self
        case .shapeText: return DefaultChartLegendCell.self
        case .custom(let typeWrapper): return typeWrapper.type
        }
    }
    
    public var reuseIdentifier: String {
        return type.reuseIdentifier
    }
}

public struct CellTypeWrapper {
    var type: UICollectionViewCell.Type
    
    public init<T>(_ type: T.Type) where T: UICollectionViewCell, T: ChartLegendCell {
        self.type = type
    }
}
