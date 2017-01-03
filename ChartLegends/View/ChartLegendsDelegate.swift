//
//  ChartLegendsDelegate.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public protocol ChartLegendsDelegate: class {
    
    func onSelectLegend(legend: ChartLegend, cell: UICollectionViewCell, indexPath: IndexPath)
}
