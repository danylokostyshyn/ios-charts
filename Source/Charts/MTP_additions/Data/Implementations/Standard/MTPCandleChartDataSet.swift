//
//  MTPCandleChartDataSet.swift
//  Charts-Extension
//
//  Copyright 2018 Romano Bayol
//

import Foundation


open class MTPCandleChartDataSet: CandleChartDataSet
{
    open override var description: String {
        return super.description + ": \(entries)"
    }
}
