//
//  AreaChartDataProvider.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation
import CoreGraphics

@objc
public protocol AreaChartDataProvider: BarLineScatterCandleBubbleChartDataProvider
{
    var areaData: AreaChartData? { get }
}
