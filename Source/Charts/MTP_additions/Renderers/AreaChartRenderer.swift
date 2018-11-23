//
//  AreaChartRenderer.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation

open class AreaChartRenderer: LineScatterCandleRadarRenderer
{
    @objc open weak var dataProvider: AreaChartDataProvider?
    
    @objc public init(dataProvider: AreaChartDataProvider, animator: Animator, viewPortHandler: ViewPortHandler)
    {
        super.init(animator: animator, viewPortHandler: viewPortHandler)
        
        self.dataProvider = dataProvider
    }
    
    open override func drawData(context: CGContext)
    {
        guard let areaData = dataProvider?.areaData else { return }
        
        for i in 0 ..< areaData.dataSetCount
        {
            guard let set = areaData.getDataSetByIndex(i) else { continue }
            
            if set.isVisible
            {
                if !(set is ScatterChartDataSetProtocol)
                {
                    fatalError("Datasets for AreaChartRenderer must conform to ScatterChartDataSetProtocol")
                }
                
                drawDataSet(context: context, dataSet: set as! ScatterChartDataSetProtocol)
            }
        }
    }
    
    @objc open func drawDataSet(context: CGContext, dataSet: ScatterChartDataSetProtocol)
    {
        guard let dataProvider = dataProvider else { return }
        
        let trans = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
        
        let phaseY = animator.phaseY
        
        let entryCount = dataSet.entryCount
        
        var point = CGPoint()
        
        let valueToPixelMatrix = trans.valueToPixelMatrix
        
        context.saveGState()
        let color = dataSet.colors[0]
        context.setFillColor(color.cgColor)
        var first = true
        var firstPoint = CGPoint()
        
        for j in 0 ..< Int(min(ceil(Double(entryCount) * animator.phaseX), Double(entryCount)))
        {
            guard let e = dataSet.entryForIndex(j) else { continue }
            
            point.x = CGFloat(e.x)
            point.y = CGFloat(e.y * phaseY)
            point = point.applying(valueToPixelMatrix)
            
            if first {
                first = false
                firstPoint.x = point.x
                firstPoint.y = point.y
                context.move(to: firstPoint)
            }
            else {
                context.addLine(to: point)
            }
        }
        
        context.addLine(to: firstPoint)
        context.fillPath()
        context.restoreGState()
    }
}
