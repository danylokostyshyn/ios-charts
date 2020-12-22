//
//  MTP_XBounds.swift
//  Charts-MTP-Extended
//
//  Created by Romano BAYOL on 22/12/2020.
//

import Foundation

func MTP_XBoundsBreakPoint() {}

open class MTP_XBounds: BarLineScatterCandleBubbleRenderer.XBounds {
    
    /// Calculates the minimum and maximum x values as well as the range between them.
    open override func set(chart: BarLineScatterCandleBubbleChartDataProvider,
                  dataSet: IBarLineScatterCandleBubbleChartDataSet,
                  animator: Animator?)
    {
        super.set(chart: chart, dataSet: dataSet, animator: animator)
        
        // Correction is needed some time
        if self.min > self.max {
            
            // From original implementation
            let low = chart.lowestVisibleX
            let high = chart.highestVisibleX
            
            let entryFrom = dataSet.entryForXValue(low, closestToY: .nan, rounding: .down)
            let entryTo = dataSet.entryForXValue(high, closestToY: .nan, rounding: .up)
            
            print("MTP_XBounds> Detected inverted min and max. min: \(min); max: \(max); low: \(low); high: \(high); entryFrom: \(String(describing: entryFrom)); entryTo: \(String(describing: entryTo)); dataSet: \(dataSet)")
            MTP_XBoundsBreakPoint()
            
            // Correction
            let minVal = self.min
            self.min = self.max
            self.max = minVal
            
            // From orignal BarLineScatterCandleBubbleRenderer.XBounds set(chart:, dataSet:, animator: Animator?) implementation
            let phaseX = Swift.max(0.0, Swift.min(1.0, animator?.phaseX ?? 1.0))
            range = Int(Double(self.max - self.min) * phaseX)
        }
    }
}
