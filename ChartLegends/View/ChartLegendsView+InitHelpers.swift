//
//  ChartLegendsView+InitHelpers.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

extension ChartLegendsView {

    public func setLegends(_ legends: [(text: String, color: UIColor)]) {
        self.legends = legends.map {DefaultPlainChartLegend(text: $0, color: $1)}
    }
    
    public func setLegends(_ shape: ChartLegendShape, _ legends: [(text: String, color: UIColor)]) {
        self.legends = legends.map {DefaultShapeChartLegend(text: $0, color: $1, shape: shape)}
    }

    public func setLegends(_ pathGenerator: @escaping (CGSize) -> UIBezierPath, _ legends: [(text: String, color: UIColor)]) {
        self.legends = legends.map {DefaultShapeChartLegend(text: $0, color: $1, pathGenerator: pathGenerator)}
    }
    
    
    public func setLegends(_ legends: (text: String, color: UIColor)...) {
        setLegends(legends)
    }
    
    public func setLegends(_ shape: ChartLegendShape, _ legends: (text: String, color: UIColor)...) {
        setLegends(shape, legends)
    }
    
    public func setLegends(_ pathGenerator: @escaping (CGSize) -> UIBezierPath, legends: (text: String, color: UIColor)...) {
        setLegends(pathGenerator, legends)
    }
}
