//
//  MTPYAxis.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation

open class MTPYAxis: YAxis
{
    // additions to display the current price text/arrow/line
    @objc public var drawCurrentValueLabel = false
    @objc public var currentValueTextColor = UIColor.white
    @objc public var currentValueBackgroundColor = UIColor.black
    @objc public var drawArrowPointerEnabled = false
    
    @objc public var currentValue: Double = 0.0
    // end additions
    
    // additions
    public func format(number: Double) -> String
    {
        return valueFormatter?.stringForValue(number, axis: self)  ?? ""
    }
    // end additions

}
