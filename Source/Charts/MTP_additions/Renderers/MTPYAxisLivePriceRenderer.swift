//
//  MTPYAxisLivePriceRenderer.swift
//  Charts-Extension
//
//  Copyright 2020 Romano Bayol
//

import Foundation

@objc open class MTPYAxisLivePriceRenderer: NSObject, MTPYAxisLivePriceRendererProtocol
{
    
    // additions
    @objc public func drawLivePrice(data: MTPYAxisLivePriceData, context: CGContext, viewPortHandler: ViewPortHandler, transformer: Transformer, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment, axis: MTPYAxis)
    {
        drawCurrentValueLine(data: data, context: context, viewPortHandler: viewPortHandler, transformer: transformer, axis: axis)
        drawLabel(data: data, context: context, viewPortHandler: viewPortHandler, transformer: transformer, fixedPosition: fixedPosition, offset: offset, textAlign: textAlign, axis: axis)
    }
    
    open func drawLabel(data: MTPYAxisLivePriceData, context: CGContext, viewPortHandler: ViewPortHandler, transformer: Transformer, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment, axis: MTPYAxis) {
        
        let currentValue = data.value
        let labelFont = axis.labelFont
        let labelTextColor = data.textColor
        let labelBackgroundColor = data.backgroundColor
        
        var pt = CGPoint()
        
        pt = transformer.pixelForValues(x: 0, y: currentValue)
        
        pt.x = fixedPosition
        pt.y += offset
        
        let formatterString = axis.format(number: currentValue)
        
        var rect = (formatterString as NSString).boundingRect(with: CGSize.zero, options: .usesFontLeading, attributes:  [.font: labelFont], context: nil)
        rect.origin = pt
        if axis.axisDependency == .left {
            rect.origin.x -= rect.width
        }
        //        rect.insetBy(dx:  -5.0, dy:  -2.0)
        //        if axis.drawArrowPointerEnabled {
        rect.insetBy(dx:  3.0, dy: 0.0)
        //        }
        
        context.addRect(rect)
        context.setFillColor(labelBackgroundColor.cgColor)
        context.fillPath()
        
        //        if axis.drawArrowPointerEnabled {
        switch axis.axisDependency {
        case .left:
            context.move(to:CGPoint(x: rect.maxX, y: rect.maxY))
            context.addLine(to:CGPoint(x: rect.maxX + 5.0, y: rect.midY))
            context.addLine(to:CGPoint(x: rect.maxX, y: rect.minY))
            context.addLine(to:CGPoint(x: rect.maxX, y: rect.maxY))
        case .right:
            context.move   (to:CGPoint(x: rect.minX, y: rect.maxY))
            context.addLine(to:CGPoint(x: rect.minX - 5.0, y: rect.midY))
            context.addLine(to:CGPoint(x: rect.minX, y: rect.minY))
            context.addLine(to:CGPoint(x: rect.minX, y: rect.maxY))
        }
        //        }
        context.closePath()
        context.fillPath()
        
        ChartUtils.drawText(
            context: context,
            text: formatterString,
            point: pt,
            align: textAlign,
            attributes: [.font: labelFont, .foregroundColor: labelTextColor]
        )
    }
    
    internal func drawCurrentValueLine(data: MTPYAxisLivePriceData, context: CGContext, viewPortHandler: ViewPortHandler, transformer: Transformer, axis: MTPYAxis)
    {
        let currentValue = data.value
        
        var lineColor = data.backgroundColor
        
        let xOffset: CGFloat = 5.0
        var startPointX: CGFloat = 0.0
        var endPointX: CGFloat = 0.0
        
        switch axis.axisDependency {
        case .left:
            startPointX = xOffset * -1
        case .right:
            endPointX = xOffset
        }
        
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
