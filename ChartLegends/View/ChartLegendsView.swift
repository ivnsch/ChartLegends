//
//  ChartLegendsCollectionView.swift
//  SwiftChartLegends
//
//  Created by Ivan Schuetz on 01/01/2017.
//  Copyright © 2017 Ivan Schuetz. All rights reserved.
//

import UIKit

open class ChartLegendsView: UIView {
    
    // MARK: - IB
    
    @IBInspectable var layoutTypeRawValue: String = ChartLegendsLayout.flowLeft.typeString {
        didSet {
            setLayoutWithRawValues()
        }
    }
    
    @IBInspectable var columns: Int = 1 {
        didSet {
            setLayoutWithRawValues()
        }
    }
    
    @IBInspectable var fontFamily: String = UIFont.systemFont(ofSize: ChartLegendsView.defaultFontSize).familyName
    @IBInspectable var fontSize: CGFloat = ChartLegendsView.defaultFontSize
    
    // MARK: - Public vars
    
    public var legends: [ChartLegend] = [] {
        didSet {
            initCellTypeWithLegendsIfNotSet()
            collectionView?.reloadData()
        }
    }
    
    public var cellConfigurator: ((UICollectionViewCell, ChartLegend, IndexPath) -> Void)?
    
    public var constraintConstants: ChartLegendsConstraintConstants?

    public weak var delegate: ChartLegendsDelegate?
    
    // MARK: - Internal / private vars
    
    weak var collectionView: UICollectionView?
    
    fileprivate var cellType: CellType?

    fileprivate var layout: ChartLegendsLayout = .flowLeft {
        didSet {
            if collectionView == nil {
                initCollectionView(layoutType: layout)
            }
        }
    }
    
    fileprivate static let defaultFontSize: CGFloat = 12
    
    lazy var font: UIFont = {
        UIFont(name: self.fontFamily, size: self.fontSize) ?? {
            print("Not possible to instantiate font with interface builder inputs. Defaulting to system font. Entered family: \(self.fontFamily), size: \(self.fontSize)")
            return UIFont.systemFont(ofSize: ChartLegendsView.defaultFontSize)
        }()
    }()
    
    // MARK: - Init
    
    public convenience init(frame: CGRect, layoutType: ChartLegendsLayout) {
        self.init(frame: frame)
        self.layout = layoutType
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView(layoutType: layout)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCollectionView(layoutType: layout)
    }

    // MARK: - Configuration
    
    public func configure<T>(cellType: T.Type, f: ((T, ChartLegend, IndexPath) -> Void)? = nil) where T: UICollectionViewCell, T: ChartLegendCell {
        configure(cellType: .custom(CellTypeWrapper(T.self)), cellConfigurator: { cell, legend, indexPath in
            f?(cell as! T, legend, indexPath)
        })
    }
    
    typealias CellConfigurator = (UICollectionViewCell, ChartLegend, IndexPath) -> Void
    
    func configure(cellType: CellType, cellConfigurator: (CellConfigurator)? = nil) {

        let cellConfigurator = cellConfigurator ?? defaultCellConfigurator(cellType: cellType)

        initConstraintConstants(cellType: cellType)
        
        register(cellType: cellType)
        
        self.cellType = cellType

        self.cellConfigurator = cellConfigurator
        
        configureCollectionView()
    }
    
    // MARK: - Private methods
    
    fileprivate func generateLayout(layoutType: ChartLegendsLayout) -> UICollectionViewLayout {
        
        func sharedFlowLayoutSettings(flowLayout: UICollectionViewFlowLayout) {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
        }
        
        switch layoutType {
            
        case .flowLeft:
            let flowLayout = LeftAlignedCollectionViewFlowLayout()
            flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
            sharedFlowLayoutSettings(flowLayout: flowLayout)
            return flowLayout
            
        case .flow: fallthrough
        case .columns(_):
            let flowLayout = UICollectionViewFlowLayout()
            sharedFlowLayoutSettings(flowLayout: flowLayout)
            return flowLayout
        }
    }
    
    fileprivate func setLayoutWithRawValues() {
        switch layoutTypeRawValue {
        case ChartLegendsLayout.flow.typeString: layout = .flow
        case ChartLegendsLayout.flowLeft.typeString: layout = .flowLeft
        case ChartLegendsLayout.columns(0).typeString: layout  = .columns(columns)
        default:
            let defaultType: ChartLegendsLayout = .flow
            print("Invalid layout type in IB: \(layoutTypeRawValue), defaulting to \(defaultType.typeString)")
            layout = defaultType
        }
    }
    
    fileprivate func initConstraintConstants(cellType: CellType) {
        if constraintConstants == nil {
            constraintConstants = (cellType.type as! ChartLegendCell.Type).defaultConstraintConstants
        }
    }
    
    fileprivate func defaultCellConfigurator(cellType: CellType) -> CellConfigurator? {
        switch cellType {
        case .plainText:
            return {[weak self] cell, legend, indexPath in guard let weakSelf = self else {return}
                let textLabelCell = cell as! TextLabelChartLegendCell
                textLabelCell.legend = weakSelf.legends[indexPath.row]
            }
        case .shapeText:
            return {[weak self] cell, legend, indexPath in guard let weakSelf = self else {return}
                let shapeTextCell = cell as! DefaultChartLegendCell
                shapeTextCell.legend = weakSelf.legends[indexPath.row] as? ShapeChartLegend
            }
            
        default: return nil
        }
    }
    
    fileprivate func register(cellType: CellType) {
        let frameworkBundleId = "com.schuetz.ChartLegends"
        if Bundle.main.path(forResource: cellType.reuseIdentifier, ofType: "nib") != nil {
            collectionView?.register(UINib(nibName: cellType.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellType.reuseIdentifier)
        } else if Bundle(identifier: frameworkBundleId)?.path(forResource: cellType.reuseIdentifier, ofType: "nib") != nil {
            collectionView?.register(UINib(nibName: cellType.reuseIdentifier, bundle: Bundle(identifier: frameworkBundleId)), forCellWithReuseIdentifier: cellType.reuseIdentifier)
        } else {
            let podBundle = Bundle(for: cellType.type)
            let bundleURL = podBundle.url(forResource: "ChartLegends", withExtension: "bundle")
            let bundle = Bundle(url: bundleURL!)!
            let nib = UINib(nibName: cellType.reuseIdentifier, bundle: bundle)
            collectionView?.register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    fileprivate func configureCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    fileprivate func initCellTypeWithLegendsIfNotSet() {
        if cellType == nil {
            if legends is [ShapeChartLegend] {
                cellType = .shapeText
            } else if legends is [PlainChartLegend] {
                cellType = .plainText
            }
            if let cellType = cellType {
                configure(cellType: cellType)
            }
        }
    }
    
    
    fileprivate func initCollectionView(layoutType: ChartLegendsLayout) {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: generateLayout(layoutType: layoutType))
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.clear
        self.collectionView = collectionView
        
        // Fill parent
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        for constraint in ["H:|[cv]|", "V:|[cv]|"] {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: [:], views: ["cv": collectionView]))
        }
    }
}

// MARK: - Collection view protocols

extension ChartLegendsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legends.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType!.reuseIdentifier, for: indexPath)
        let legend = legends[indexPath.row]
        
        var chartLegendCell = cell as! ChartLegendCell
        chartLegendCell.defaultFont = font
        if let constraintConstants = constraintConstants {
            chartLegendCell.initConstraints(constants: constraintConstants)
        }
        cellConfigurator?(cell, legend, indexPath)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let staticSize = constraintConstants?.staticSize ?? CGSize.zero
        let legend = legends[indexPath.row]
        let variableSize = legend.contentSize(font: legend.font ?? font)
        
        switch layout {
        case .flow: fallthrough
        case .flowLeft:
            return CGSize(width: variableSize.width + staticSize.width + 2, height: variableSize.height + staticSize.height)
            
        case .columns(let count):
            let columnWidth = collectionView.bounds.width / CGFloat(count)
            return CGSize(width: columnWidth, height: variableSize.height + staticSize.height)
            
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let legend = legends[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath)
        delegate?.onSelectLegend(legend: legend, cell: cell!, indexPath: indexPath)
    }
}
