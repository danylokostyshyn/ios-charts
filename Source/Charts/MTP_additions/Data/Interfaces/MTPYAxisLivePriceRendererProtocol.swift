//
//  MTPYAxisLivePriceRendererProtocol.swift
//  Charts-Extension
//
//  Created by Romano Bayol on 18/02/2020.
//

import Foundation

@objc public protocol MTPYAxisLivePriceRendererProtocol
{
    
    func drawLivePrice(data: MTPYAxisLivePriceData, context: CGContext, viewPortHandler: ViewPortHandler, transformer: Transformer, fixedPosition: CGFloat, offset: CGFloat, textAlign: NSTextAlignment, axis: MTPYAxis)
}
