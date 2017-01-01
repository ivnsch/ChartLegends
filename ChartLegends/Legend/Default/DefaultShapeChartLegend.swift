//
//  DefaultShapeChartLegend.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 02/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

public class DefaultShapeChartLegend: DefaultPlainChartLegend, ShapeChartLegend {

    public let shape: ChartLegendShape
    
    public var pathGenerator: ((CGSize) -> UIBezierPath)?
    
    public convenience init(text: String, color: UIColor, shape: ChartLegendShape) {
        self.init(text: text, color: color, font: nil, shape: shape)
    }

    public convenience init(text: String, color: UIColor, pathGenerator: @escaping ((CGSize) -> UIBezierPath)) {
        self.init(text: text, color: color, font: nil, pathGenerator: pathGenerator)
    }
    
    public convenience init(text: String, color: UIColor, font: UIFont?, shape: ChartLegendShape) {
        self.init(text: text, color: color, font: font, shape: shape, pathGenerator: nil)
    }

    public convenience init(text: String, color: UIColor, font: UIFont?, pathGenerator: @escaping ((CGSize) -> UIBezierPath)) {
        self.init(text: text, color: color, font: font, shape: .circle(radius: 8), pathGenerator: pathGenerator)
    }

    init(text: String, color: UIColor, font: UIFont?, shape: ChartLegendShape, pathGenerator: ((CGSize) -> UIBezierPath)?) {
        self.shape = shape
        self.pathGenerator = pathGenerator
        super.init(text: text, color: color, font: font)
    }
}
