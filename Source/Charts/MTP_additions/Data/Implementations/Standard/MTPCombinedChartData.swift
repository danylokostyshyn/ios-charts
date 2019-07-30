//
//  MTPCombinedChartData.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation

open class MTPCombinedChartData : CombinedChartData
{
    private var _areaData: AreaChartData!
    
    public override init(dataSets: [IChartDataSet]?)
    {
        super.init(dataSets: dataSets)
    }
    
    public required init(arrayLiteral elements: IChartDataSet...)
    {
        super.init(dataSets: elements)
    }
    
    @objc open var areaData: AreaChartData!
    {
        get
        {
            return _areaData
        }
        set
        {
            _areaData = newValue
            notifyDataChanged()
        }
    }
    
    /// - returns: All data objects in row: line-bar-scatter-candle-bubble-area if not null.
    @objc override open var allData: [ChartData]
    {
        var data = super.allData
        
        if areaData !== nil
        {
            data.append(areaData)
        }
        
        return data
    }
    
    open override func notifyDataChanged()
    {
        _areaData?.notifyDataChanged()

        super.notifyDataChanged() // recalculate everything
    }
}
