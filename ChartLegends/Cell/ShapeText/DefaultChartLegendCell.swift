//
//  DefaultChartLegendCell.swift
//  SwiftChartLegends
//
//  Created by Ivan Schuetz on 28/12/2016.
//  Copyright © 2016 Ivan Schuetz. All rights reserved.
//

import UIKit

public class DefaultChartLegendCell: UICollectionViewCell, ChartLegendCell {

    @IBOutlet public weak var shape: UIView!
    @IBOutlet public weak var label: UILabel!
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var shapeWidth: NSLayoutConstraint!
    @IBOutlet weak var shapeToLabel: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    public var defaultFont: UIFont?
    
    public static var defaultConstraintConstants: ChartLegendsConstraintConstants = DefaultChartLegendConstraintConstants()
    
    public var legend: ShapeChartLegend? {
        didSet {
            if let legend = legend {
                label.text = legend.text
                
                label.font = legend.font ?? defaultFont

                let shapeLayer = CAShapeLayer()

                let circlePath: UIBezierPath = legend.pathGenerator?(CGSize(width: shapeWidth.constant, height: shapeWidth.constant)) ?? {
                    switch legend.shape {
                    case .circle(let radius): return UIBezierPath(arcCenter: CGPoint(x: shape.bounds.center.x, y: shape.bounds.center.y), radius: radius, startAngle: 0, endAngle: (2 * CGFloat(CGFloat.pi)), clockwise: true)
                    case .rect(let width, let height): return UIBezierPath(rect: CGRect(x: shape.bounds.center.x - width / 2, y: shape.bounds.center.y - height / 2, width: width, height: height))
                    }
                }()
                
                shapeLayer.path = circlePath.cgPath
                shapeLayer.fillColor = legend.color.cgColor
                shapeLayer.frame = shape.bounds
                shape.layer.addSublayer(shapeLayer)
                
            }
        }
    }
    
    public func initConstraints(constants: ChartLegendsConstraintConstants) {
        let c = constants as! DefaultChartLegendConstraintConstants
        leading.constant = c.leading
        shapeWidth.constant = c.shapeWidth
        shapeToLabel.constant = c.shapeToLabel
        trailing.constant = c.trailing
    }
}

public struct DefaultChartLegendConstraintConstants: ChartLegendsConstraintConstants {
    public var leading: CGFloat = 4
    public var shapeWidth: CGFloat = 20
    public var shapeToLabel: CGFloat = 4
    public var trailing: CGFloat = 4
    
    public init() {}
    
    public var staticSize: CGSize {
        return CGSize(width: leading + shapeWidth + shapeToLabel + trailing, height: shapeWidth)
    }
}
