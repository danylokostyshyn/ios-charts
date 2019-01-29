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
    
    // Overriding ChartViewBase's xAxis getter/setter to return mtpXAxis and avoid original value to be set
    override open var xAxis: XAxis {
        get {
            return mtpXAxis
        }
        set {
            
        }
    }
    
    // Overriding BarLineChartViewBase's leftAxis getter/setter to return mtpLeftAxis and avoid original value to be set
    override open var leftAxis: YAxis {
        get {
            return mtpLeftAxis
        }
        set {
            
        }
    }
    
    // Overriding BarLineChartViewBase's rightAxis getter/setter to return mtpRightAxis and avoid original value to be set
    override open var rightAxis: YAxis {
        get {
            return mtpRightAxis
        }
        set {
            
        }
    }
    
    // Overriding BarLineChartViewBase's leftYAxisRenderer getter/setter to return mtpLeftYAxisRenderer and avoid original value to be set
    override open var leftYAxisRenderer: YAxisRenderer {
        get {
            return mtpLeftYAxisRenderer
        }
        set {
            
        }
    }
    
    // Overriding ChartViewBase's xAxisRenderer getter/setter to return mtpXAxisRenderer and avoid original value to be set
    override open var xAxisRenderer: XAxisRenderer {
        get {
            return mtpXAxisRenderer
        }
        set {
            
        }
    }
    
    // Overriding BarLineChartViewBase's rightYAxisRenderer getter/setter to return mtpRightYAxisRenderer and avoid original value to be set
    override open var rightYAxisRenderer: YAxisRenderer {
        get {
            return mtpRightYAxisRenderer
        }
        set {
            
        }
    }
    
    // To replace ChartViewBase's xAxis
    @objc open internal(set) var mtpXAxis = MTPXAxis()
    
    // To replace BarLineChartViewBase's leftAxis
    @objc open internal(set) var mtpLeftAxis = MTPYAxis(position: .left)
    
    // To replace BarLineChartViewBase's rightAxis
    @objc open internal(set) var mtpRightAxis = MTPYAxis(position: .right)
    
    // To replace ChartViewBase's xAxisRenderer
    @objc open lazy var mtpXAxisRenderer = MTPXAxisRenderer(viewPortHandler: viewPortHandler, axis: xAxis, transformer: _leftAxisTransformer)
    
    // To replace BarLineChartViewBase's leftYAxisRenderer
    @objc open lazy var mtpLeftYAxisRenderer = MTPYAxisRenderer(viewPortHandler: viewPortHandler, axis: leftAxis, transformer: _leftAxisTransformer)
    
    // To replace BarLineChartViewBase's rightYAxisRenderer
    @objc open lazy var mtpRightYAxisRenderer = MTPYAxisRenderer(viewPortHandler: viewPortHandler, axis: rightAxis, transformer: _rightAxisTransformer)
    
    
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
        
        showAnnotationView(highlight: highlighted.first)
    }
    
    @objc open override func highlightValue(x: Double, y: Double, dataSetIndex: Int, dataIndex: Int = -1, callDelegate: Bool)
    {
        super.highlightValue(x: y, y: y, dataSetIndex: dataSetIndex, dataIndex: dataIndex, callDelegate: callDelegate)
        
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
            let e = data.entry(for: h)
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
