//
//  MTPXAxisRenderer.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPXAxisRenderer: XAxisRenderer
{
    
    open override func renderGridLines(context: CGContext)
    {
        guard let transformer = self.transformer else { return }
        
        guard let mtpXAxis = axis as? MTPXAxis else {
            print("expected MTPXAxis !")
            return
        }
        
        if !axis.isDrawGridLinesEnabled || !axis.isEnabled
        {
            return
        }
        
        // additions
        context.setFillColor(mtpXAxis.evenBarsColor.cgColor)
        // end additions
        
        context.saveGState()
        defer { context.restoreGState() }
        context.clip(to: self.gridClippingRect)
        
        context.setShouldAntialias(axis.gridAntialiasEnabled)
        context.setStrokeColor(axis.gridColor.cgColor)
        context.setLineWidth(axis.gridLineWidth)
        context.setLineCap(axis.gridLineCap)
        
        if axis.gridLineDashLengths != nil
        {
            context.setLineDash(phase: axis.gridLineDashPhase, lengths: axis.gridLineDashLengths)
        }
        else
        {
            context.setLineDash(phase: 0.0, lengths: [])
        }
        
        let valueToPixelMatrix = transformer.valueToPixelMatrix
        
        var position = CGPoint(x: 0.0, y: 0.0)
        
        let entries = axis.entries
        
        // additions
        var itter = 0
        // end additions
        for i in stride(from: 0, to: entries.count, by: 1)
        {
            position.x = CGFloat(entries[i])
            position.y = position.x
            position = position.applying(valueToPixelMatrix)
            
            // additions
            itter += 1
            if (itter % 2 == 0) {
                let x =  CGFloat(entries[i-1])
                var prevPosition = CGPoint(x: x, y: 0.0)
                prevPosition = prevPosition.applying(valueToPixelMatrix)
                let width = position.x - prevPosition.x
                let height = viewPortHandler.contentBottom - viewPortHandler.contentTop
                let rect = CGRect.init(x: position.x, y: viewPortHandler.contentTop, width: width, height: height)
                context.fill(rect)
                
                if itter == 2 {
                    let rect = CGRect.init(x: position.x - 2 * width, y: viewPortHandler.contentTop, width: width, height: height)
                    context.fill(rect)
                }
            }
            // end additions
            
            drawGridLine(context: context, x: position.x, y: position.y)
        }
    }
}
