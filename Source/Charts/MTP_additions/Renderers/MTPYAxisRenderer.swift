//
//  MTPYAxisRenderer.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPYAxisRenderer: YAxisRenderer
{
    
    // Overrides YAxisRenderer's drawYLabels
    internal override func drawYLabels(
        context: CGContext,
        fixedPosition: CGFloat,
        positions: [CGPoint],
        offset: CGFloat,
        textAlign: NSTextAlignment)
    {
        let labelFont = axis.labelFont
        let labelTextColor = axis.labelTextColor
        
        let from = axis.isDrawBottomYLabelEntryEnabled ? 0 : 1
        let to = axis.isDrawTopYLabelEntryEnabled ? axis.entryCount : (axis.entryCount - 1)
        
        for i in stride(from: from, to: to, by: 1)
        {
            let text = axis.getFormattedLabel(i)
            
            context.drawText(text,
                             at: CGPoint(x: fixedPosition, y: positions[i].y + offset),
                             align: textAlign,
                             attributes: [.font: labelFont, .foregroundColor: labelTextColor])
        }
        
        // additions
        guard let axis = axis as? MTPYAxis,
            axis.drawCurrentValueLabel else {
                print("expected MTPYAxis !")
                return
        }
        drawCurrentValueLabel(context: context, fixedPosition: fixedPosition, offset: offset, textAlign: textAlign, mtpYAXis: axis)
        // end additions
    }
    
    // additions
    internal func drawCurrentValueLabel(context: CGContext, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment, mtpYAXis: MTPYAxis)
    {
        guard let transformer = self.transformer else { return }

        let currentValue = mtpYAXis.currentValue
        let labelFont = mtpYAXis.labelFont
        let labelTextColor = mtpYAXis.currentValueTextColor
        let labelBackgroundColor = mtpYAXis.currentValueBackgroundColor

        let valueToPixelMatrix = transformer.valueToPixelMatrix

        var pt = CGPoint()

        pt = transformer.pixelForValues(x: 0, y: currentValue)

        pt.x = fixedPosition
        pt.y += offset

        let formatterString = mtpYAXis.format(number: currentValue)

        var rect = (formatterString as NSString).boundingRect(with: CGSize.zero, options: .usesFontLeading, attributes:  [.font: labelFont], context: nil)
        rect.origin = pt
        if mtpYAXis.axisDependency == .left {
            rect.origin.x -= rect.width
        }
        rect.insetBy(dx:  -5.0, dy:  -2.0)
        if mtpYAXis.drawArrowPointerEnabled {
             rect.insetBy(dx:  3.0, dy: 0.0)
        }

        context.addRect(rect)
        context.setFillColor(labelBackgroundColor.cgColor)
        context.fillPath()

        if mtpYAXis.drawArrowPointerEnabled {
            switch mtpYAXis.axisDependency {
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
            context.closePath()
            context.fillPath()
        }

        context.drawText(formatterString,
                         at: pt,
                         align: textAlign,
                         attributes: [.font: labelFont, .foregroundColor: labelTextColor])
    }
    // end additions
}
