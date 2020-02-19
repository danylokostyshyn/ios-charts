//
//  MTPYAxisLivePriceData.swift
//  Charts-Extension
//
//  Created by Romano Bayol on 18/02/2020.
//

import Foundation

@objcMembers final public class MTPYAxisLivePriceData: NSObject
{
    public let value: Double
    public let backgroundColor: UIColor
    public let textColor: UIColor
    
    @objc public init(value: Double, backgroundColor: UIColor, textColor: UIColor) {
        self.value = value
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
}
