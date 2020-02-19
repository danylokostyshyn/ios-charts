//
//  MTPYAxisRenderer.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPYAxisRenderer: YAxisRenderer
{
    private let livePriceRenderer: MTPYAxisLivePriceRendererProtocol
    @objc public init(viewPortHandler: ViewPortHandler, yAxis: YAxis?, transformer: Transformer?, livePriceRenderer: MTPYAxisLivePriceRendererProtocol)
    {
        self.livePriceRenderer = livePriceRenderer
        super.init(viewPortHandler: viewPortHandler, yAxis: yAxis, transformer: transformer)
    }
    
    // Overrides YAxisRenderer's drawYLabels
    internal override func drawYLabels(
        context: CGContext,
        fixedPosition: CGFloat,
        positions: [CGPoint],
        offset: CGFloat,
        textAlign: NSTextAlignment)
    {
        guard
            let yAxis = self.axis as? YAxis
            else { return }
        
        let labelFont = yAxis.labelFont
        let labelTextColor = yAxis.labelTextColor
        
        let from = yAxis.isDrawBottomYLabelEntryEnabled ? 0 : 1
        let to = yAxis.isDrawTopYLabelEntryEnabled ? yAxis.entryCount : (yAxis.entryCount - 1)
        
        for i in stride(from: from, to: to, by: 1)
        {
            let text = yAxis.getFormattedLabel(i)
            
            ChartUtils.drawText(
                context: context,
                text: text,
                point: CGPoint(x: fixedPosition, y: positions[i].y + offset),
                align: textAlign,
                attributes: [.font: labelFont, .foregroundColor: labelTextColor]
            )
        }
        
        // additions
        guard let axis = axis as? MTPYAxis, let transformer = self.transformer else {
                print("expected MTPYAxis !")
                return
        }
        
        for data in axis.livePriceDataSet.reversed() {
            livePriceRenderer.drawLivePrice(data: data, context: context, viewPortHandler: viewPortHandler, transformer: transformer, fixedPosition: fixedPosition, offset: offset, textAlign: textAlign, axis: axis)
        }
    }
}
