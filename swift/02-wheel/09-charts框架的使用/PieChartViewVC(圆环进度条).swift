//
//  NextViewController.swift
//  test01
//
//  Created by michael on 2021/6/25.
//

import UIKit
import Charts

/// 圆环进度条的基本使用
class PieChartViewVC: UIViewController {
    
    lazy var ringChtView: PieChartView = {
        let chartView = PieChartView()
        
        // 是否显示扇形区域文字label
        chartView.drawEntryLabelsEnabled = false
        // 是否显示中心文字
        chartView.drawCenterTextEnabled = false
        // 是否绘制气泡
        chartView.drawMarkers = false
        // 是否显示饼状图图例解释说明
        chartView.legend.enabled = false
        // 是否显示饼状图描述文字
        chartView.chartDescription?.enabled = false
        // 没有数据时显示的文案
        chartView.noDataText = ""
        
        // 是否根据所提供的数据, 将显示数据转换为百分比格式
        chartView.usePercentValuesEnabled = true
        // 饼状图距离边缘的间隙
        chartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        
        // 禁止点击手势高亮显示值
        chartView.highlightPerTapEnabled = false
        // 拖拽饼状图后是否有惯性效果
        chartView.dragDecelerationEnabled = false
        // 不允许拖拽旋转
        chartView.rotationEnabled = false
        
        // 饼状图是否是空心圆
        chartView.drawHoleEnabled = true
        // 中心内圆的颜色
        chartView.holeColor = .white
        // 中心内圆半径占比，以此来控制圆环宽度
        chartView.holeRadiusPercent = 50.0/54.0
        // 第二个内圆颜色
        chartView.transparentCircleColor = .clear
        // 第二个内圆半径占比
        chartView.transparentCircleRadiusPercent = 0.0
        return chartView
    }()
    
    lazy var dataSet: PieChartDataSet = {
        let dataSet = PieChartDataSet(entries: [PieChartDataEntry(value: 100)])
        // 是否显示默认数值
        dataSet.drawValuesEnabled = false
        dataSet.colors = [UIColor(0xECECEC)]
        // 饼状图是否允许选中放大
        dataSet.highlightEnabled = false
        // 选中区块时, 放大的半径。如不设置则圆环不会填充整个布局空间
        dataSet.selectionShift = 0
        return dataSet
    }()
    
    lazy var chtData: PieChartData = {
        let data = PieChartData(dataSet: self.dataSet)
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "next"
        self.view.backgroundColor = .white
    
        ringChtView.data = self.chtData
        self.view.addSubview(ringChtView)
        
        ringChtView.snp.makeConstraints {
            $0.size.equalTo(108)
            $0.center.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let status = Int.random(in: 0...3)
        if status == 0 {
            
            self.dataSet.colors = [UIColor(0xECECEC)]
            self.dataSet.replaceEntries([PieChartDataEntry(value: 100)])
            
        } else {
            
            var dataEntryArr: [PieChartDataEntry] = []
            for _ in 0..<4 {
                let num = Int.random(in: 0...100)
                let value = PieChartDataEntry(value: Double(num))
                dataEntryArr.append(value)
            }
            self.dataSet.colors = [UIColor(0xFFE9C2), UIColor(0xCAB08A), UIColor(0xF4BB57), UIColor(0xE67F53)]
            self.dataSet.replaceEntries(dataEntryArr)
        }
        
        self.ringChtView.data = self.chtData
    }

}
