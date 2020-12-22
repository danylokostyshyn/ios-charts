//
//  CandleStickChartView+Extensions.swift
//  Charts-MTP-Extended
//
//  Created by Romano BAYOL on 22/12/2020.
//

import Foundation


public extension CandleStickChartView {
    
    @objc func switchToMTPRenderer() {
        renderer = MTPCandleStickChartRenderer(dataProvider: self, animator: _animator, viewPortHandler: _viewPortHandler)
    }
    
}
