//
//  MTPCombinedChartView.swift
//  Charts + MTP Additions
//
//  Created by Romano Bayol on 23/11/2018.
//


import Foundation

open class MTPCombinedChartView: CombinedChartView, MTPCombinedChartDataProvider
{
    /// enum that allows to specify the order in which the different data objects for the combined-chart are drawn
    @objc(MTPCombinedChartMTPDrawOrder)
    public enum MTPDrawOrder: Int
    {
        case bar
        case bubble
        case line
        case candle
        case scatter
        case area
    }
    
    @objc public var annotationView: UIView?
    @objc public var currentValue: Double = 0.0
    /// the number of x-values the chart displays
    internal var _deltaX = Double(1.0)
    
    open override func initialize()
    {
        super.initialize()
        
        renderer = MTPCombinedChartRenderer(mtpchart: self, animator: chartAnimator, viewPortHandler: viewPortHandler)
    }
    
    // MARK: - CombinedChartDataProvider
    
    open var mtpCombinedData: MTPCombinedChartData?
        {
        get
        {
            return data as? MTPCombinedChartData
        }
    }
 
    // MARK: - AreaChartData
    
    open var areaData: AreaChartData?
        {
        get
        {
            return mtpCombinedData?.areaData
        }
    }
    
    // MARK: - Annotation View
    open override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        
        let optionalContext = NSUIGraphicsGetCurrentContext()
        guard let context = optionalContext else { return }
        
        showAnnotationView(highlight: highlighted.first)
    }
    
    @objc open override func highlightValue(x: Double, dataSetIndex: Int, callDelegate: Bool)
    {
        super.highlightValue(x: x, dataSetIndex: dataSetIndex, callDelegate: callDelegate)
        
        showAnnotationView(highlight: lastHighlighted)
    }
    
    private func showAnnotationView(highlight: Highlight?) {
        guard let view = annotationView,
            let data = data,
            let h = highlight else {
                hideAnnotationView()
                return
        }
        
        let xIndex = h.dataSetIndex
        
        if (xIndex <= Int(_deltaX) && xIndex <= Int(_deltaX * chartAnimator.phaseX))
        {
            let e = data.entryForHighlight(h)
            if (e === nil || e!.y != h.y)
            {
                hideAnnotationView()
                return
            }
            
            let pos = CGPoint(x: h.xPx, y: h.yPx)
            view.center = pos
            
            let rect = view.frame.insetBy(dx: view.bounds.width/4, dy: view.bounds.height/4)
            if (viewPortHandler.contentRect.contains(rect) != true)
            {
                hideAnnotationView()
                return
            }
            
            if view.superview == nil {
                addSubview(view)
                setNeedsDisplay()
            }
        }
    }
    
    private func hideAnnotationView() {
        guard let view = annotationView else { return }
        
        view.removeFromSuperview()
    }
    
}
