//
//  ViewController.swift
//  ChartLegends
//
//  Created by Ivan Schuetz on 01/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit
import ChartLegends

class ViewController: UIViewController, ChartLegendsDelegate {
    
    @IBOutlet var horizontalFlowSmallLegendsView: ChartLegendsView!
    @IBOutlet var horizontalFlowLegendsView: ChartLegendsView!
    @IBOutlet var columnsLegendsView: ChartLegendsView!
    @IBOutlet var singleColumnLegendsView: ChartLegendsView!
    
    let legends = [
        (text: "Chemicals", color: UIColor.orange),
        (text: "Forestry", color: UIColor.green),
        (text: "Construction", color: UIColor.gray),
        (text: "Aerospace", color: UIColor.purple),
        (text: "Automobiles", color: UIColor.blue),
        (text: "Oil & Gas", color: UIColor.black),
        (text: "Health", color: UIColor.red),
        (text: "Electricity", color: UIColor.magenta),
        (text: "Finance", color: UIColor.cyan),
        (text: "Insurance", color: UIColor.darkGray),
        (text: "Technology", color: UIColor.brown)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        horizontalFlowSmallLegendsView.setLegends(.rect(width: 12, height: 12), Array(legends[0...2]))
        
        
        horizontalFlowLegendsView.setLegends(.circle(radius: 7),
             (text: "Chemicals", color: UIColor.orange),
             (text: "Forestry", color: UIColor.green)
        )
        
        horizontalFlowLegendsView.setLegends(.circle(radius: 7), legends)
        columnsLegendsView.setLegends(legends)
        
        customPathExample()
        
        horizontalFlowSmallLegendsView.delegate = self
        horizontalFlowLegendsView.delegate = self
        columnsLegendsView.delegate = self
        singleColumnLegendsView.delegate = self
    }
    
    
    fileprivate func customPathExample() {
        /* We use a default shape for all the cells, except for the cell called "Health", where we use a path generator to generate a heart shape.
        This demonstrates 2 things: On one side, that it's possible to pass a custom path, and on the other, that it's possible to pass different settings, like shape or font, to individual cells.
        Note that using `map` here is only for demo purposes, to reuse the legends array we already have. You may want to create directly the array with `DefaultShapeChartLegend` instances. */
        let defaultShape: ChartLegendShape = .rect(width: 14, height: 5)
        let mixedShapeLegends: [DefaultShapeChartLegend] = legends.map {
            if $0 == "Health" {
                return DefaultShapeChartLegend(text: $0, color: $1, pathGenerator: {size in
                    self.createHeartPath(size: size, scale: 1)
                })
            } else {
                return DefaultShapeChartLegend(text: $0, color: $1, shape: defaultShape)
            }
        }
        
        singleColumnLegendsView.legends = mixedShapeLegends
    }
    
  
    // src: http://stackoverflow.com/a/35555206/930450 (modified)
    fileprivate func createHeartPath(size: CGSize, scale: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let scaledWidth = (size.width * CGFloat(scale))
        let scaledXValue = ((size.width) - scaledWidth) / 2
        let scaledHeight = (size.height * CGFloat(scale))
        let scaledYValue = ((size.height) - scaledHeight) / 2
        
        let scaledRect = CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)
        path.move(to: CGPoint(x: size.width / 2, y: scaledRect.origin.y + scaledRect.size.height))
        
        path.addCurve(to: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height / 4)),
                             controlPoint1: CGPoint(x: scaledRect.origin.x + (scaledRect.size.width / 2), y: scaledRect.origin.y + (scaledRect.size.height * 3 / 4)) ,
                             controlPoint2: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height / 2)) )
        
        path.addArc(withCenter: CGPoint(x: scaledRect.origin.x + (scaledRect.size.width / 4), y: scaledRect.origin.y + (scaledRect.size.height / 4)),
                              radius: (scaledRect.size.width / 4),
                              startAngle: CGFloat(CGFloat.pi),
                              endAngle: 0,
                              clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: scaledRect.origin.x + (scaledRect.size.width * 3 / 4), y: scaledRect.origin.y + (scaledRect.size.height / 4)),
                              radius: (scaledRect.size.width / 4),
                              startAngle: CGFloat.pi,
                              endAngle: 0,
                              clockwise: true)
        
        path.addCurve(to: CGPoint(x: size.width/2, y: scaledRect.origin.y + scaledRect.size.height),
                             controlPoint1: CGPoint(x: scaledRect.origin.x + scaledRect.size.width, y: scaledRect.origin.y + (scaledRect.size.height/2)),
                             controlPoint2: CGPoint(x: scaledRect.origin.x + (scaledRect.size.width / 2), y: scaledRect.origin.y + (scaledRect.size.height * 3 / 4)) )
        path.close()
        return path
    }
    
    
    // MARK: - ChartLegendsDelegate
    
    func onSelectLegend(legend: ChartLegend, cell: UICollectionViewCell, indexPath: IndexPath) {
        print("Selected legend: \(legend.text)")
    }
}
