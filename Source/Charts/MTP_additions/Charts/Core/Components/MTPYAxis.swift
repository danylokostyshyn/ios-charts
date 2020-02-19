//
//  MTPYAxis.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPYAxis: YAxis
{
    @objc public var currentValue: Double = 0.0
    @objc public var livePriceDataSet: [MTPYAxisLivePriceData] = []
    
    
    // additions
    public func format(number: Double) -> String
    {
        return valueFormatter?.stringForValue(number, axis: self)  ?? ""
    }
    // end additions

}
