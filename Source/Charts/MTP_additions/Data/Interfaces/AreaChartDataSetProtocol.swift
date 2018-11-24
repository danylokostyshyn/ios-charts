//
//  ScatterChartDataSetProtocol.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//

import Foundation
import CoreGraphics

@objc
public protocol AreaChartDataSetProtocol: LineScatterCandleRadarChartDataSetProtocol
{
    // MARK: - Data functions and accessors
    
    // MARK: - Styling functions and accessors
    
    /// - returns: Color for the area fill. Setting to `nil` will behave as transparent.
    /// **default**: nil
    var areafillColor: NSUIColor? { get }
}
