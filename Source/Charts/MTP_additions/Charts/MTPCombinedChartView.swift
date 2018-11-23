//
//  MTPCombinedChartView.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//


import Foundation

open class MTPCombinedChartView: CombinedChartView, MTPCombinedChartDataProvider
{
    
    open override func initialize()
    {
        super.initialize()
        
        renderer = MTPCombinedChartRenderer(mtpchart: self, animator: chartAnimator, viewPortHandler: viewPortHandler)
    }
    
    // MARK: - CombinedChartDataProvider
    
    open var mtpCombinedData: MTPCombinedChartData?
        {
        get
        {
            return data as? MTPCombinedChartData
        }
    }
 
    // MARK: - AreaChartData
    
    open var areaData: AreaChartData?
        {
        get
        {
            return mtpCombinedData?.areaData
        }
    }
    
}
