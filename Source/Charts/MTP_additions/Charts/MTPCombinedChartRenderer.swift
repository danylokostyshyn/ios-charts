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
    // Original is [.bar, .bubble, .line, .candle, .scatter]
    internal var _mtpDrawOrder: [MTPCombinedChartView.MTPDrawOrder] = [.bar, .bubble, .line, .candle, .scatter, .area]
    
    @objc open weak var mtpchart: MTPCombinedChartView?
    
    @objc public init(mtpchart: MTPCombinedChartView, animator: Animator, viewPortHandler: ViewPortHandler)
    {
        self.mtpchart = mtpchart
        super.init(chart: mtpchart, animator: animator, viewPortHandler: viewPortHandler)
    }
    
    /// the order in which the provided data objects should be drawn.
    /// The earlier you place them in the provided array, the further they will be in the background.
    /// e.g. if you provide [DrawOrder.Bar, DrawOrder.Line], the bars will be drawn behind the lines.
    open var mtpDrawOrder: [MTPCombinedChartView.MTPDrawOrder]
        {
        get
        {
            return _mtpDrawOrder
        }
        set
        {
            if newValue.count > 0
            {
                _mtpDrawOrder = newValue
            }
        }
    }
    
    
    /// Creates the renderers needed for this combined-renderer in the required order. Also takes the DrawOrder into consideration.
    override internal func createRenderers()
    {
        _renderers = [DataRenderer]()
        
        guard let chart = chart else { return }
        
        for order in mtpDrawOrder
        {
            switch (order)
            {
            case .bar:
                if chart.barData !== nil
                {
                    _renderers.append(BarChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
                }
                break
                
            case .line:
                if chart.lineData !== nil
                {
                    _renderers.append(LineChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
                }
                break
                
            case .candle:
                if chart.candleData !== nil
                {
                    _renderers.append(MTPCandleStickChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
                }
                break
                
            case .scatter:
                if chart.scatterData !== nil
                {
                    _renderers.append(ScatterChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
                }
                break
                
            case .bubble:
                if chart.bubbleData !== nil
                {
                    _renderers.append(BubbleChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
                }
                break
                
            case .area:
                guard let chart = mtpchart else { break }
                if chart.areaData !== nil {
                    _renderers.append(AreaChartRenderer(dataProvider: chart, animator: animator, viewPortHandler: viewPortHandler))
                }
                break
            }
        }
        
    }
}
