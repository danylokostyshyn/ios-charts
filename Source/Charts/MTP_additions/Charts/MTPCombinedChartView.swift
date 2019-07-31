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
    
    public override init(frame: CGRect)
    {
        mtpXAxis = MTPXAxis()
        mtpLeftAxis = MTPYAxis(position: .left)
        mtpRightAxis = MTPYAxis(position: .right)
        super.init(frame: frame)
        _xAxis = mtpXAxis
        leftAxis = mtpLeftAxis
        rightAxis = mtpRightAxis
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        mtpXAxis = MTPXAxis()
        mtpLeftAxis = MTPYAxis(position: .left)
        mtpRightAxis = MTPYAxis(position: .right)
        super.init(coder: aDecoder)
        _xAxis = mtpXAxis
        leftAxis = mtpLeftAxis
        rightAxis = mtpRightAxis
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
    @objc open internal(set) var mtpXAxis: MTPXAxis {
        didSet {
            _xAxis = mtpXAxis
        }
    }
    
    // To replace BarLineChartViewBase's leftAxis
    // MTPYAxis(position: .left) {
    @objc open internal(set) var mtpLeftAxis: MTPYAxis {
        didSet {
            leftAxis = mtpLeftAxis
        }
    }
    
    // To replace BarLineChartViewBase's rightAxis
    // MTPYAxis(position: .right)
    @objc open internal(set) var mtpRightAxis: MTPYAxis {
        didSet {
            rightAxis = mtpRightAxis
        }
    }
    
    // To replace ChartViewBase's xAxisRenderer
    @objc open lazy var mtpXAxisRenderer = MTPXAxisRenderer(viewPortHandler: viewPortHandler, xAxis: xAxis, transformer: _leftAxisTransformer)
    
    // To replace BarLineChartViewBase's leftYAxisRenderer
    @objc open lazy var mtpLeftYAxisRenderer = MTPYAxisRenderer(viewPortHandler: viewPortHandler, yAxis: leftAxis, transformer: _leftAxisTransformer)
    
    // To replace BarLineChartViewBase's rightYAxisRenderer
    @objc open lazy var mtpRightYAxisRenderer = MTPYAxisRenderer(viewPortHandler: viewPortHandler, yAxis: rightAxis, transformer: _rightAxisTransformer)
    
    
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
    
//    @objc open override func highlightValue(x: Double, dataSetIndex: Int, callDelegate: Bool)
//    {
//        super.highlightValue(x: x, dataSetIndex: dataSetIndex, callDelegate: callDelegate)
//
//        showAnnotationView(highlight: lastHighlighted)
//    }
    
    @objc open override func highlightValue(_ highlight: Highlight?, callDelegate: Bool) {
        super.highlightValue(highlight, callDelegate: callDelegate)
        
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
            // Do not cross left border
            view.frame.origin.x = max(view.frame.origin.x, viewPortHandler.offsetLeft)
            // Do not cross right border
            view.frame.origin.x = min(view.frame.origin.x + view.frame.width, frame.width - viewPortHandler.offsetRight) - view.frame.width
            // Do not cross top border
            view.frame.origin.y = max(view.frame.origin.y, viewPortHandler.offsetTop)
            // Do not cross bottom border
            view.frame.origin.y = min(view.frame.origin.y + view.frame.height, frame.height - viewPortHandler.offsetBottom) - view.frame.height
            
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
