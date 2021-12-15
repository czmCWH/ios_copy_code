
import UIKit
import EachNavigationBar

/// 在自控制器之间导航
class ChildViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    

    lazy var pageControllers = [RedViewController(), OrangeViewController(), GreenViewController()]

    lazy var pageViewController: UIPageViewController = {
        
        /* options 是一个配置字典，包含2个key
         .interPageSpacing： 仅在 transitionStyle 为 .scroll 时生效。表示 两个 VC 的view之间的间隔
         .spineLocation：仅在 transitionStyle 为 .pageCurl 时生效。
                UIPageViewController.SpineLocation.min      单页显示, 从上往下翻页
                UIPageViewController.SpineLocation.mid      双页显示
                UIPageViewController.SpineLocation.max      单页显示, 从下往上翻
         */
        let options: [UIPageViewController.OptionsKey : Any] = [.interPageSpacing: 10, .spineLocation: UIPageViewController.SpineLocation.max]
        
        /*
         transitionStyle：过渡类型：.scroll（左右滑动 ）；.pageCurl（上下翻页, 类似翻书）
         navigationOrientation：导航方向：.horizontal（水平方向(左右滑动或翻页)）；.vertical（竖直方向(上下滑动或翻页)）
         */
        let pageVc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        pageVc.dataSource = self
        pageVc.delegate = self
        // 是否双面显示, 当 UIPageViewController.SpineLocation.mid 时, 默认为true, 其他情况默认为false
//        pageVc.isDoubleSided = false
        return pageVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigation.item.title = "UIPageViewController"
        
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
        
        // 默认显示`微博`页面
        showChildViewController(at: 0)
    }
    
    func showChildViewController(at index: Int) {
        if index >= pageControllers.count || index < 0 { return }
        var currentIndex = 0
        if let currentVC = pageViewController.viewControllers?.last,
           let idx = pageControllers.firstIndex(of: currentVC) {
            currentIndex = idx
        }
        let toVC = pageControllers[index]
        // .forward：从左往右（或从下往上）；.reverse：从右向左（或从上往下）
        let direction: UIPageViewController.NavigationDirection = (currentIndex > index) ? .reverse : .forward
        
        /*  该方法用于设置要显示的 VC
         
         @param1 viewControllers 参数取值：
         
            如果 transitionStyle 为 .pageCurl，则参数 viewControllers 取决于 .spineLocation 和 isDoubleSided 的值，如下表：
         
            spineLocation       isDoubleSided               viewControllers
         
                .mid                true            传递要在左侧显示的页面和要在右侧显示的页面
                .min or .max        true            传递要显示的页面的正面和先前显示的页面的背面。背面用于翻页动画.
                .min or .max        false           传递要显示的页面的正面。
         
            如果 transitionStyle 为 .scroll，则参数 viewControllers 只需要传递一个当前显示的 VC
         
         @param2 direction 参数取值：forward：从左往右（或从下往上）；.reverse：从右向左（或从上往下）
         
         */
        pageViewController.setViewControllers([toVC], direction: direction, animated: true, completion: nil)
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    // 返回给定视图控制器之前的视图控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if pageControllers.count == 0 { return nil }
        guard let index = pageControllers.firstIndex(of: viewController)
            else { return nil }
        if index > 0 {
            return pageControllers[index-1]
        }
        return nil
    }

    // 返回在给定的视图控制器之后视图控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if pageControllers.count == 0 { return nil }
        guard let index = pageControllers.firstIndex(of: viewController)
        else { return nil }
        if index < pageControllers.count - 1 {
            return pageControllers[index+1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 2
    }

    func presentationIndex(for: UIPageViewController) -> Int {
        return 111
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    // 在手势驱动的转换开始之前调用
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    // 在手势驱动的转换完成后调用
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
    // 在  transitionStyle 为 .pageCurl（上下翻页, 类似翻书）时使用。
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        .none
    }
    
    
    func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        .all
    }

    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        .portraitUpsideDown
    }
    
    
    
}
