//
//  AreaChartData.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation
import CoreGraphics

open class AreaChartData : ScatterChartData
{
    public override init(dataSets: [IChartDataSet]?)
    {
        super.init(dataSets: dataSets)
    }
    
    public required init(arrayLiteral elements: IChartDataSet...)
    {
        super.init(dataSets: elements)
    }
}
