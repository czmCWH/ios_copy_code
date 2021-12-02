//
//  UseCharts.swift
//  test01
//
//  Created by czm on 2021/9/6.
//

// 使用博客介绍：第三方图表库Charts使用详解[8] -- 来自航歌：hangge --> https://www.hangge.com/blog/cache/detail_2116.html

/// 使用基于：pod 'Charts', '~> 3.6.0'

import UIKit
import Charts

class UseCharts: NSObject, ChartViewDelegate {
    
    /// 折线图View
    lazy var chartView: LineChartView = {
        let chtView =  LineChartView()
        chtView.backgroundColor = .clear
        chtView.chartDescription?.enabled = false
        // 禁止X轴缩放
        chtView.scaleXEnabled = false
        // 禁止Y轴缩放
        chtView.scaleYEnabled = false
        // 禁止x、y轴同时缩放
        chtView.pinchZoomEnabled = false
        // 禁止单击缩放
        chtView.doubleTapToZoomEnabled = false
        // 隐藏图标右下角图例
        chtView.legend.enabled = false
        
        // 设置显示X轴
        chtView.xAxis.enabled = true
        // 设置X轴不绘制网格
        chtView.xAxis.drawGridLinesEnabled = false
        // 设置绘制X轴
        chtView.xAxis.drawAxisLineEnabled = true
        // 设置绘制X轴坐标点
        chtView.xAxis.drawLabelsEnabled = true
        // 设置X轴的位置
        chtView.xAxis.labelPosition = .bottom
        // 设置X轴线宽、颜色
        chtView.xAxis.axisLineColor = UIColor(0x656060)
        chtView.xAxis.axisLineWidth = 1
        
        // 设置横坐标的字体
        chtView.xAxis.labelFont = UIFont.systemFont(ofSize: 11)
        chtView.xAxis.labelTextColor = UIColor(0xC6C6C6)
        
        // 设置Y轴
        // 不绘制右侧Y轴
        chtView.rightAxis.enabled = false
        chtView.leftAxis.enabled = true
        // Y轴不绘制网格
        chtView.leftAxis.drawGridLinesEnabled = false
        chtView.leftAxis.drawLabelsEnabled = true
        // 设置Y轴线宽、颜色
        chtView.leftAxis.axisLineColor = UIColor(0x656060)
        chtView.leftAxis.axisLineWidth = 1
        
        // 设置Y轴坐标点颜色
        chtView.leftAxis.labelTextColor = UIColor(0xC6C6C6)
        chtView.leftAxis.labelFont = UIFont.systemFont(ofSize: 11)
        
        // chant view 右侧偏移量
        chtView.extraRightOffset = 35
        chtView.extraBottomOffset = 5
        chtView.extraTopOffset = 45
        
        // 自动计算最大值
//        chtView.leftAxis.resetCustomAxisMin()
//        chtView.leftAxis.resetCustomAxisMax()
        chtView.leftAxis.axisMinimum = 0
    
        /// 设置X轴显示的变量
        chtView.leftAxis.valueFormatter = ZMYAxisValueFormatter()
        
        
        return chtView
    }()
    
    /// 折线图的数据对象
    lazy var chartData = LineChartData()
    
    /// 折线配置数据对象
    lazy var dataSet: LineChartDataSet = {
        let dataSet = LineChartDataSet(label: "Number")
        // 折线显示时重复颜色
        dataSet.colors = [UIColor(0xF0D79E)]
        // 折线显示模式为弧线
        dataSet.mode = .horizontalBezier
        // 折线宽度
        dataSet.lineWidth = 2
        // 设置折线曲率
//        dataSet.cubicIntensity = 0.1
        
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
            
        // 是否绘制拐点
        dataSet.drawCirclesEnabled = false
        // 拐点半径
        dataSet.circleRadius = 1.5
        
        // 拐点处不显示数字
        dataSet.drawValuesEnabled = false
        dataSet.drawIconsEnabled = false
        // 拐点颜色
        dataSet.circleColors = [.red]
        // 是否画拐点空心圆
        dataSet.drawCircleHoleEnabled = false
        
        // 是否渐变填充光影效果
        dataSet.drawFilledEnabled = true
        let gradientColors = [UIColor(0x101010).withAlphaComponent(0.0).cgColor, UIColor(0xF5DDA4).cgColor]
        let gradientRef = CGGradient.init(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)
        dataSet.fillAlpha = 1.0
        dataSet.fill = Fill.fillWithLinearGradient(gradientRef!, angle: 90.0)
        return dataSet
    }()
    
    /// 更新X轴
    func updateXLineAxisStyle() {
        // 设置X轴最大值和最小值
        self.chartView.xAxis.axisMinimum = 1
        self.chartView.xAxis.axisMaximum = 7
        // 设置X轴label数量
        self.chartView.xAxis.setLabelCount(7, force: true)
        
        self.chartView.xAxis.valueFormatter = ZMXAxisValueFormatter()
    }
    
    
    /// 更新折线图上点的数据
    func updateLineData() {
        
        var dataEntryArr = [ChartDataEntry]()
        
        for model in dataArr {
            if i == model.crosswise {
                value = ChartDataEntry(x: Double(model.crosswise), y: model.data / 100)
            }
        }
        
        self.dataSet.replaceEntries(dataEntryArr)
        self.chartData.addDataSet(dataSet)
        self.chartView.data = self.chartData
    }
    
    // MARK: ChartViewDelegate
    
    /// 点击折线图，显示气泡
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let markView = ZMChartMarkerView(frame: CGRect(x: 0, y: 0, width: 78, height: 42))
        markView.offset = CGPoint(x: -39, y: -(42 + 6))
        markView.chartView = self.chartView
        chartView.marker = markView
    }
    
}

// MARK: - 自定义设置 Charts 折线图 X 轴坐标格式

class ZMXAxisValueFormatter: IAxisValueFormatter {
    
    private lazy var dayStrArray = getMonthDay()
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
//        print("===czm 30天===", Int(value))
        
        switch Int(value) {
        case 1:
            return self.dayStrArray.first ?? ""
        case 29:
            return self.dayStrArray.last ?? ""
        default:
            return ""
        }
    }
    
    /// 获取30天的日期
    private func getMonthDay() -> [String] {
        let formate = DateFormatter()
//        formate.dateFormat = "yyyy-MM-dd"
        formate.dateFormat = "MM-dd"
//        formate.locale = Locale(identifier: "zh_CN")
//        formate.timeZone = TimeZone(abbreviation: "CST")
        
        let nowDate = Date()
        var arr: [String] = []
        for i in 0...29 {
            let newDate = Calendar.current.date(byAdding: .day, value: -1 * i, to: nowDate) ?? Date()
            arr.append(formate.string(from: newDate))
        }
        arr.reverse()
        return arr
    }
}


// MARK: - 自定义设置 Charts 折线图 Y 轴坐标格式

class ZMYAxisValueFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let maxValue = axis?.axisMaximum ?? 0.0
        
        if maxValue == 12500 {
            if value == 0.00 {
                return "¥0.00"
            } else {
                return ""
            }
        } else {
            if value < 0 {
                return ""
            } else if value > maxValue / 5.0 * 4 {
                return ""
            } else {
                return "¥" + String(format: "%.2f", value)
            }
        }
    }
}


// MARK: - 设置 charts 折线图拐点气泡 view

class ZMChartMarkerView: MarkerView {
    
    /// 7日数据
    private lazy var dayStrArray = getMonthDay(7)
    /// 30日数据
    private lazy var monthStrArray = getMonthDay(30)
    
    lazy var xLabel: UILabel = {
        let lab = UILabel(font: UIFont.zm_pf_regular(size: 12), color: UIColor(0x232323), alignment: .center)
        return lab
    }()
    
    lazy var yLabel: UILabel = {
        let lab = UILabel(font: UIFont.zm_pf_medium(size: 14), color: UIColor(0x232323), alignment: .center)
        return lab
    }()
    
    lazy var shapLayer: CAShapeLayer = {
        let lay = CAShapeLayer()
        lay.fillColor = UIColor(0xF0D79E).cgColor
        lay.lineJoin = .round
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: 0))
        linePath.addLine(to: CGPoint(x: 6, y: 0))
        linePath.addLine(to: CGPoint(x: 3, y: 5))
        linePath.close()
        lay.path = linePath.cgPath
        return lay
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(0xF0D79E)
        
        self.add(xLabel, yLabel)
        self.layer.addSublayer(shapLayer)
        
        xLabel.frame = CGRect(x: 0, y: 3, width: self.width, height: 17)
        yLabel.frame = CGRect(x: 0, y: self.height - 25, width: self.width, height: 25)
        shapLayer.frame = CGRect(x: self.width * 0.5 - 3, y: self.height, width: 6, height: 5)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        
        let maxXValue = Int(self.chartView?.xAxis.axisMaximum ?? 0.0)
        
        switch maxXValue {
        case 23:        // 今日
            var idx = "\(Int(entry.x))"
            if idx.count == 1 {
                idx = "0" + "\(idx):00"
            } else {
                idx = "\(idx):00"
            }
            xLabel.text = idx
        case 7:         // 7日
            let idx = Int(entry.x) - 1
            if idx < 0 {
                xLabel.text = self.dayStrArray.first
            } else if idx > 6 {
                xLabel.text = self.dayStrArray.last
            } else {
                xLabel.text = self.dayStrArray[idx]
            }
        case 30:        // 30日
            let idx = Int(entry.x) - 1
            if idx < 0 {
                xLabel.text = self.monthStrArray.first
            } else if idx > 29 {
                xLabel.text = self.monthStrArray.last
            } else {
                xLabel.text = self.monthStrArray[idx]
            }
        default:
            break
        }
        
        let priceStr = "¥" + String(format: "%.2f", entry.y)
        let priceAttri = NSMutableAttributedString(string: priceStr)
        priceAttri.addAttributes([.font: UIFont.zm_pf_medium(size: 11), .foregroundColor: UIColor(0x232323)], range: NSRange(location: 0, length: 1))
        priceAttri.addAttributes([.font: UIFont.zm_pf_medium(size: 14), .foregroundColor: UIColor(0x232323)], range: NSRange(location: 1, length: priceStr.count - 1))
        yLabel.attributedText = priceAttri
        
    }

    /// 获取n天的日期
    private func getMonthDay(_ n: Int) -> [String] {
        let formate = DateFormatter()
//        formate.dateFormat = "yyyy-MM-dd"
        formate.dateFormat = "MM-dd"
//        formate.locale = Locale(identifier: "zh_CN")
//        formate.timeZone = TimeZone(abbreviation: "CST")
        
        let nowDate = Date()
        var arr: [String] = []
        for i in 0...(n - 1) {
            let newDate = Calendar.current.date(byAdding: .day, value: -1 * i, to: nowDate) ?? Date()
            arr.append(formate.string(from: newDate))
        }
        arr.reverse()
        return arr
    }
}
