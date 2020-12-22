//
//  MTPBubbleChartRenderer.swift
//  Charts-MTP-Extended
//
//  Created by Romano BAYOL on 22/12/2020.
//

import Foundation


open class MTPBubbleChartRenderer: BubbleChartRenderer
{
    @objc public override init(dataProvider: BubbleChartDataProvider, animator: Animator, viewPortHandler: ViewPortHandler) {
        super.init(dataProvider: dataProvider, animator: animator, viewPortHandler: viewPortHandler)
        
        _xBounds = MTP_XBounds()
    }
}
