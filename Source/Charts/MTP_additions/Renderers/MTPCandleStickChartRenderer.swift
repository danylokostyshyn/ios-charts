//
//  MTPCandleStickChartRenderer.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPCandleStickChartRenderer: CandleStickChartRenderer
{
    
    open override func drawExtras(context: CGContext)
    {
        super.drawExtras(context: context)
        
        guard let dataProvider = dataProvider,
            let candleData = dataProvider.candleData,
            let dataSet = candleData.dataSets.first as? MTPCandleChartDataSet  else { return }
        
        if dataSet.drawCurrentValueLine {
            drawCurrentValueLine(context: context)
        }
    }
    
    public func drawCurrentValueLine(context: CGContext)
    {
        guard let dataProvider = dataProvider as? MTPCombinedChartDataProvider,
            let candleData = dataProvider.candleData else {
                print("Expected MTPCombinedChartDataProvider !")
                return
        }
        
        let currentValue = dataProvider.currentValue
        
        var dataSets = candleData.dataSets
        for (i, _) in dataSets.enumerated()
        {
            let dataSet = dataSets[i]
            
            let transformer = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
            
            var lineColor = UIColor.black
            if let dataSet = dataSet as? MTPCandleChartDataSet {
                lineColor = dataSet.currentValueLineColor
            }
            
            let xOffset: CGFloat = 5.0
            var startPointX: CGFloat = 0.0
            var endPointX: CGFloat = 0.0
            
            switch dataSet.axisDependency {
            case .left:
                startPointX = xOffset * -1
            case .right:
                endPointX = xOffset
            }
            
            let data = dataProvider.candleData?.dataSets[0]
            
            let point = transformer.pixelForValues(x: 0, y: currentValue)
            let y = point.y - 1
            
            let movePoint = CGPoint(x: viewPortHandler.contentRect.minX + startPointX, y: y)
            let addLinePoint = CGPoint(x: viewPortHandler.contentRect.maxX + endPointX, y: y)
            
            context.beginPath()
            context.setLineWidth(1.0)
            context.setStrokeColor(lineColor.cgColor)
            context.move(to: movePoint)
            context.addLine(to: addLinePoint)
            context.strokePath()
        }
    }
}
