//
//  MTPCombinedChartDataProvider.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation
import CoreGraphics

@objc
public protocol MTPCombinedChartDataProvider: CombinedChartDataProvider, AreaChartDataProvider
{
    var mtpCombinedData: MTPCombinedChartData? { get }
}
