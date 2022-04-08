// MARK: - 通用系统高度System

/// 状态栏高度
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let kNavBarHeight: CGFloat = 44.0
/// 状态栏+导航栏的高度
let kStatusAndNavBarHeight: CGFloat = (kStatusBarHeight + kNavBarHeight)
/// 底部菜单栏高度
let kTabBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height > 20.0 ? 83.0:49.0)

/// 屏幕宽度
let kScreenW: CGFloat = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenH: CGFloat = UIScreen.main.bounds.height
let kScreenScale = UIScreen.main.scale


// MARK: - 通用闭包

/// 无参数闭包
typealias FWVoidBlock = ()->Void
/// 通用的完成回调
typealias FWIsFinishedBlock = (_ isFinished: Bool)->Void
/// 通用的错误回调
typealias FWErrorBlock = (_ errCode: Int, _ errMsg: String?)->Void

// MARK: - 把一组数分为几行几列,九宫格
func test1() {
    let dataCount = dataArray.count + 1
    let surplus = dataCount%4
    let row = dataCount/4 + (dataCount%4 == 0 ? 0 : 1)
}

// MARK: - UI属性特殊写法

do {
    private var imageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "fail")
        $0.backgroundColor = .clear
        return $0
    } ( UIImageView() )
    
    public lazy var button: UIButton = {
        $0.titleLabel?.font = UIFont(name: "GillSans-UltraBold", size: 20)
        $0.setTitle("好难过~戳我重试一下 (˶‾᷄ ⁻̫ ‾᷅˵) ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    } ( UIButton() )
}
