//
//  ZMGradientLineChartView.swift
//  test01
//
//  Created by czm on 2021/7/22.
//
/* 使用示例：
 let chartView2 = ZMGradientLineChartView()
 chartView2.xAxisLabelCount = 10
 chartView2.yAxisMinimum = 0
 chartView2.yAxisMaximum = 100
 chartView2.entries = [LineChartPoint(x: 0.5, y: 11), LineChartPoint(x: 1.5, y: 22), LineChartPoint(x: 2.5, y: 55), LineChartPoint(x: 3.5, y: 77), LineChartPoint(x: 4.5, y: 90), LineChartPoint(x: 5.5, y: 12), LineChartPoint(x: 6.5, y: 67), LineChartPoint(x: 7.5, y: 40)]
 self.view.addSubview(chartView2)

 chartView2.snp.makeConstraints {
     $0.center.equalToSuperview()
     $0.width.equalToSuperview()
     $0.height.equalTo(200)
 }
 */


import UIKit

struct LineChartPoint: Equatable {
    var x: Double
    var y: Double
    
    static func ==(_ left: LineChartPoint, _ right: LineChartPoint) -> Bool {
           left.x == right.x && left.y == right.y ? true : false
    }
}

/// 渐变折线图
class GradientLineChartView: UIView {
    
    // MARK: public property
    
    /// 坐标点
    var entries: [LineChartPoint] = [] {
        didSet {
            guard oldValue != entries else { return }
            drawLinePoint()
        }
    }
    /// X轴分段数量
    var xAxisLabelCount: Int = 0
    /// Y轴最小值
    var yAxisMinimum: Double = 0.0
    /// Y轴最大值
    var yAxisMaximum: Double = 0.0
    
    // MARK: private property
    
    /// 填充层背景渐变图层
    private lazy var fillGradientView = KDPGradientView()
    /// 填充层蒙版
    private lazy var fillShapLayer = CAShapeLayer()
    /// 填充层路径
    private lazy var fillPath = UIBezierPath()
    
    
    /// 渐变线背景渐变图层
    private lazy var lineGradientView = KDPGradientView()
    /// 渐变线蒙版
    private lazy var lineShapLayer = CAShapeLayer()
    /// 渐变线路径
    private lazy var linePath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFillView()
        setupLineView()
        
        self.addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    /// 创建渐变线条View
    private func setupLineView() {
        lineGradientView.colors = [UIColor(0x3D306A), UIColor(0x3F3E75), UIColor(0x456291), UIColor(0x4E9BBD), UIColor(0x54C1DB), UIColor(0x51B9D7), UIColor(0x3D86BC), UIColor(0x2F61A9), UIColor(0x264A9D), UIColor(0x234299)]
        lineGradientView.startPoint = CGPoint(x: 0, y: 0.5)
        lineGradientView.endPoint = CGPoint(x: 1.0, y: 0.5)
        lineGradientView.locations = [0.1, 0.2, 0.3, 0.4, 0.5, 0.5, 0.7, 0.8, 0.9, 1.0]
        self.addSubview(lineGradientView)
        
        lineGradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        lineShapLayer.lineWidth = 3.0
        lineShapLayer.fillColor = UIColor.clear.cgColor
        lineShapLayer.strokeColor = UIColor.black.cgColor
        lineShapLayer.strokeEnd = 1.0
        lineShapLayer.lineCap = .butt
        lineShapLayer.lineJoin = .round
    }
    
    /// 创建填充背景View
    private func setupFillView() {
        fillGradientView.colors = [UIColor(0x34436C), UIColor(0x101010).withAlphaComponent(0.0)]
        fillGradientView.startPoint = CGPoint(x: 0.5, y: 0)
        fillGradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        fillGradientView.locations = [0.5]
        self.addSubview(fillGradientView)
        
        fillGradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        fillShapLayer = CAShapeLayer()
        fillShapLayer.lineWidth = 3.0
        fillShapLayer.lineCap = .butt
        fillShapLayer.lineJoin = .round
        fillShapLayer.fillRule = .nonZero
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "bounds" || keyPath == "frame" {
            drawLinePoint()
        }
    }
    
    /// 绘制坐标点
    private func drawLinePoint() {
        
        self.linePath.removeAllPoints()
        self.fillPath.removeAllPoints()
    
        if self.bounds.equalTo(.zero) { return }
        
        let chartW = self.bounds.size.width
        let chartH = self.bounds.size.height
       
        if entries.count == 1 {     // 只有一个点时，显示小圆点
            
            let pt = entries[0]
            let x = chartW / CGFloat(xAxisLabelCount) * CGFloat(pt.x)
            let y = chartH * CGFloat( 1 - pt.y / (yAxisMaximum - yAxisMinimum))
            
            self.linePath.move(to: CGPoint(x: x, y: y))
            self.linePath.addLine(to: CGPoint(x: x, y: y))
            
            self.lineShapLayer.lineCap = .round
            self.reloadLine()
            
        } else {    // 多个点时，绘制线
            
            var startPT: CGPoint = .zero
            var endPT: CGPoint = .zero
            
            for i in 0..<entries.count {
                
                let pt = entries[i]
                let x = chartW / CGFloat(xAxisLabelCount) * CGFloat(pt.x)
                var y = chartH * CGFloat( 1 - pt.y / (yAxisMaximum - yAxisMinimum))
                if pt.y == yAxisMaximum { y = 3 }
        
                if i == 0 {
                    self.linePath.move(to: CGPoint(x: x, y: y))
                    self.fillPath.move(to: CGPoint(x: x, y: y))
                    startPT = CGPoint(x: x, y: chartH)
                } else {
                    self.linePath.addLine(to: CGPoint(x: x, y: y))
                    self.fillPath.addLine(to: CGPoint(x: x, y: y))
                    
                    if i == entries.count - 1 {
                        endPT = CGPoint(x: x, y: chartH)
                        
                        self.fillPath.addLine(to: endPT)
                        self.fillPath.addLine(to: startPT)
                        self.fillPath.close()
                    }
                }
            }
            self.lineShapLayer.lineCap = .butt
            self.reloadLine()
        }
    }
    
    /// 重新绘制线
    private func reloadLine() {
        self.fillShapLayer.path = self.fillPath.cgPath
        self.fillGradientView.layer.mask = self.fillShapLayer
        
        self.lineShapLayer.path = self.linePath.cgPath
        self.lineGradientView.layer.mask = self.lineShapLayer
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "bounds")
        self.removeObserver(self, forKeyPath: "frame")
    }

}


