//
//  MTPCandleStickChartRenderer.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPCandleStickChartRenderer: CandleStickChartRenderer
{
    @objc public override init(dataProvider: CandleChartDataProvider, animator: Animator, viewPortHandler: ViewPortHandler) {
        super.init(dataProvider: dataProvider, animator: animator, viewPortHandler: viewPortHandler)
        
        _xBounds = MTP_XBounds()
    }
    
    open override func drawExtras(context: CGContext)
    {
        super.drawExtras(context: context)
    }
}
