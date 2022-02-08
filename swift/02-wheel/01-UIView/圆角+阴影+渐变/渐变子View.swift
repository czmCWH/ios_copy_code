// 此类用于处理渐变色的View
// 参考博客：
// https://www.jianshu.com/p/e7c9e94e165b
// https://github.com/AlfredZY/AZTools
//
// 博客方法的缺点：一旦分类重写了layerClass方法，则所有的view都会被重写。
// 因此我才用继承方式

import UIKit

class GradientView: UIView {
    
    /// 每个渐变停止的颜色
    var colors: [UIColor]? = nil {
        willSet {
            var arr: [CGColor] = []
            for item in (newValue ?? []) {
                arr.append(item.cgColor)
            }
            (self.layer as? CAGradientLayer)?.colors = arr
        }
    }
    
    /// 每个渐变停止点的位置，取值为 0.0~1.0
    var locations: [Float]? = nil {
        willSet {
            var arr: [NSNumber] = []
            for item in (newValue ?? []) {
                arr.append(NSNumber(value: item))
            }
            (self.layer as? CAGradientLayer)?.locations = arr
        }
    }
    
    /// 渐变的起点，起点对应于渐变的第一个停止点，默认值(0.5,0.0)
    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        willSet {
            (self.layer as? CAGradientLayer)?.startPoint = newValue
        }
    }
    
    /// 终点对应渐变的最后一个停止点，默认值为（0.5,1.0）
    var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        willSet {
            (self.layer as? CAGradientLayer)?.endPoint = newValue
        }
    }
    
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    func addGradientColor(_ colors: [UIColor], _ locations: [Float], start: CGPoint = CGPoint(x: 0.5, y: 0), end: CGPoint = CGPoint(x: 0.5, y: 1.0), _ type: CAGradientLayerType = .axial) {
        self.colors = colors
        self.locations = locations
        self.startPoint = start
        self.endPoint = end
        (self.layer as? CAGradientLayer)?.type = type
    }
    
    /// 清除渐变效果
    func clearGradient() {
        self.colors = nil
        self.locations = nil
        self.startPoint = CGPoint(x: 0.5, y: 0)
        self.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}

class GradientButton: UIButton {
    /// 每个渐变停止的颜色
    var colors: [UIColor]? = nil {
        willSet {
            var arr: [CGColor] = []
            for item in (newValue ?? []) {
                arr.append(item.cgColor)
            }
            (self.layer as? CAGradientLayer)?.colors = arr
        }
    }
    
    /// 每个渐变停止点的位置，取值为 0.0~1.0
    var locations: [Float]? = nil {
        willSet {
            var arr: [NSNumber] = []
            for item in (newValue ?? []) {
                arr.append(NSNumber(value: item))
            }
            (self.layer as? CAGradientLayer)?.locations = arr
        }
    }
    
    /// 渐变的起点，起点对应于渐变的第一个停止点，默认值(0.5,0.0)
    var startPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        willSet {
            (self.layer as? CAGradientLayer)?.startPoint = newValue
        }
    }
    
    /// 终点对应渐变的最后一个停止点，默认值为（0.5,1.0）
    var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        willSet {
            (self.layer as? CAGradientLayer)?.endPoint = newValue
        }
    }
    
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    func addGradientColor(_ colors: [UIColor], _ locations: [Float], start: CGPoint = CGPoint(x: 0.5, y: 0), end: CGPoint = CGPoint(x: 0.5, y: 1.0), _ type: CAGradientLayerType = .axial) {
        self.colors = colors
        self.locations = locations
        self.startPoint = start
        self.endPoint = end
        (self.layer as? CAGradientLayer)?.type = type
    }
    
    /// 清除渐变效果
    func clearGradient() {
        self.colors = nil
        self.locations = nil
        self.startPoint = CGPoint(x: 0.5, y: 0)
        self.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}
