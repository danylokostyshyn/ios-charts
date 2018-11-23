//
//  CombinedChartRenderer.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation
import CoreGraphics

open class MTPCombinedChartRenderer: CombinedChartRenderer
{
    @objc open weak var mtpchart: MTPCombinedChartView?
    
    @objc public init(mtpchart: MTPCombinedChartView, animator: Animator, viewPortHandler: ViewPortHandler)
    {
        self.mtpchart = mtpchart
        super.init(chart: mtpchart, animator: animator, viewPortHandler: viewPortHandler)
    }
    
    override internal func createRenderers()
    {
        super.createRenderers()
        
        guard let chart = mtpchart else { return }
        if chart.areaData != nil{
            _renderers.append(AreaChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
        }
    }
}
