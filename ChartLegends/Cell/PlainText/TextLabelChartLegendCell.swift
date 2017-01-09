//
//  TextLabelChartLegendCell.swift
//  SwiftChartLegends
//
//  Created by Ivan Schuetz on 29/12/2016.
//  Copyright © 2016 Ivan Schuetz. All rights reserved.
//

import UIKit

public class TextLabelChartLegendCell: UICollectionViewCell, ChartLegendCell {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    public static var defaultConstraintConstants: ChartLegendsConstraintConstants = TextLabelChartLegendConstraintConstants()
    
    public var defaultFont: UIFont?
    
    public var legend: ChartLegend? {
        didSet {
            if let legend = legend {
                
                label.text = legend.text
                label.textColor = legend.color
                
                label.font = legend.font ?? defaultFont
            }
        }
    }
    
    public func initConstraints(constants: ChartLegendsConstraintConstants) {
        let c = constants as! TextLabelChartLegendConstraintConstants
        leadingConstraint.constant = c.leading
        topConstraint.constant = c.top
        trailingConstraint.constant = c.trailing
        bottomConstraint.constant = c.bottom
    }
}


public struct TextLabelChartLegendConstraintConstants: ChartLegendsConstraintConstants {
    
    public var leading: CGFloat = 10
    public var top: CGFloat = 10
    public var trailing: CGFloat = 10
    public var bottom: CGFloat = 10
    
    public init() {}
    
    public var staticSize: CGSize {
        return CGSize(width: leading + trailing, height: top + bottom)
    }
}
