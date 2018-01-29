//
//  File.swift
//  Pods
//
//  Created by aternovyy on 1/29/18.
//

import UIKit
import Foundation
import Charts

@objc(ChartXAxisFormatter)
public class XAxisFormatter: NSObject, AxisValueFormatter
{
    private var _values: [NSNumber] = [NSNumber]()
    private var _valueCount: Int = 0
    
    @objc public var dateFormatter: DateFormatter?
    
    @objc public var values: [NSNumber]
    {
        get
        {
            return _values
        }
        set
        {
            _values = newValue
            _valueCount = _values.count
        }
    }
    
    public override init()
    {
        super.init()
    }
    
    @objc public init(values: [NSNumber], dateFormatter:DateFormatter)
    {
        super.init()
        
        self.values = values
        self.dateFormatter = dateFormatter
    }
    
    @objc public static func with(values: [NSNumber], dateFormatter:DateFormatter) -> XAxisFormatter?
    {
        return XAxisFormatter(values: values, dateFormatter:dateFormatter )
    }

    
    public  func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        let index = Int(value)
        
        if self.values.count <= index  { return "" }
        guard let dateFormatter = dateFormatter else { return ""}

        let timestamp = self.values[index]
        let date = Date.init(timeIntervalSince1970: timestamp.doubleValue)
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
}
