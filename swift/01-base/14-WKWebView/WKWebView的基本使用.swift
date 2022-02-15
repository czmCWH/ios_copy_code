/*
 
 YungFan/Swift与JS通过WKWebView互调  https://cloud.tencent.com/developer/article/1765101
 
 feijunjie/WKWebView相关整理篇 https://feijunjie.github.io/2020/05/30/20200530-WKWebView相关整理篇/
 
 http://blog.darkangel7.com/2017/05/10/iOS中UIWebView与WKWebView、JavaScript与OC交互、Cookie管理看我就够（中）/
 
 https://juejin.cn/post/6844903534505230344
 
 百度App技术 * WKWebView 加载生命周期与代理方法剖析 https://mp.weixin.qq.com/s/83ZUNuWSCrVO3vrIGQr8tA
 
 搜狐 * 干货：探秘WKWebView https://mp.weixin.qq.com/s/l9D4V0ON3uJ0HfsJ7bpJiQ
 
 [WKWebView的local storage数据同步的问题](https://mp.weixin.qq.com/s/-mVJmCUIDDK0XckYhEhGGQ)

 QiShare/iOS UIWebView、WKWebView注入Cookie https://www.jianshu.com/p/ac2bc832d35a
 
 设置自定义UserAgent：https://juejin.cn/post/6844903632152821773
 
 若要封装 WKWebView 请参考，其中包含WKWebView+UITableView混排：[wsl2ls/WKWebView](https://github.com/wsl2ls/WKWebView)
 
 
 

 
 
 1、JS 调用 原生(Swift) 中方法的方式
 
 方式一：URL拦截
    通过在 WKNavigationDelegate 的代理方法进行拦截处理
 
 方式二：注册 scriptMessageHandler
    向 WKUserContentController 添加 JS 调用原生的方法名称，并在其代理方法中拦截
    
 2、原生(Swift) 调用 JS 中方法的方式
    self.webView evaluateJavaScript:@"document.title" completionHandler:
 
 3、拦截 JS 的 alert 函数调用，通过系统的弹窗来替代。
 
 */


import UIKit
import WebKit

class WebViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        // 出现在用户代理字符串中的应用程序名称
        webConfiguration.applicationNameForUserAgent = "czm_app"
        
        // 1、设置网页的偏好设置(最小字体大小、JS行为、欺诈网站行为等)
        let preferences = WKPreferences()
        // 是否启用JS，默认值为true
        preferences.javaScriptEnabled = true
        // 指示JS是否可以在没有用户交互的情况下打开windows。默认值为false
        preferences.javaScriptCanOpenWindowsAutomatically = true
        webConfiguration.preferences = preferences
        
        // 2、为web View管理Cookie、磁盘和内存缓存以及其他类型数据的对象。
        // 创建一个数据存储对象，将网站数据存储在内存中，不将数据写入磁盘。
        let websiteDataStore = WKWebsiteDataStore.nonPersistent()
        webConfiguration.websiteDataStore = websiteDataStore
        
        // 3、WKUserContentController 用于管理 JS 和 swift 之间的交互、注入js代码、以及过滤web视图中的内容。
        let userContentController = WKUserContentController()
        
        // 3.1、添加 JS 调用 swift 的方法名称。此方法需要实现 WKScriptMessageHandler 协议，从该协议中响应JS调用的方法；并且需要在适当的地方调用remove
        // 在 JS 中，通过这 window.webkit.messageHandlers.<name>.postMessage(<messageBody>) 来调用 Swift 中的方法。注意messageBody中不能包含js的function，如果包含了function，那么 OC端将不会收到回调。
        userContentController.add(self, name: "nativeAction")
        
        // 3.2、将指定的脚本注入到网页的内容中
        
        // 在页面开始加载时注入一个Cookie
        let userScript = WKUserScript(source: "document.cookie = 'DarkAngelCookie=DarkAngel;", injectionTime: .atDocumentStart, forMainFrameOnly: false)
         userContentController.addUserScript(userScript)
        
        // 注入一个脚本，每当页面加载完成，就会alert当前页面cookie
        let cookieScript = WKUserScript(source: "alert(document.cookie);", injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        userContentController.addUserScript(cookieScript)
        
        webConfiguration.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        // 允许webview上下回弹
        webView.scrollView.alwaysBounceVertical = true
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .automatic
        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
        webView.uiDelegate = self       // 主要拦截一些 alert、打开新窗口等
        webView.navigationDelegate = self       // 加载成功、失败、是否允许跳转
        // 设置webView的用户代理字符串，用于给JS判断当前在那个页面内。比如：iOS和Android加载同一个h5下载页面，JS通过设置的UA来判断当前在哪儿。
        webView.customUserAgent = "test_app/1.0.0"
        // 允许右滑返回上个链接，左滑前进，默认值为false
        webView.allowsBackForwardNavigationGestures = true
        // 在iOS上默认为false，标识不允许链接预览
        webView.allowsLinkPreview = true
        // 标识是否支持放大手势，默认为NO（允许链接3D Touch）
        webView.allowsMagnification = false
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    deinit {
        // 移除
        if #available(iOS 14.0, *) {
            webView.configuration.userContentController.removeAllScriptMessageHandlers()
        } else {
            webView.configuration.userContentController.removeScriptMessageHandler(forName: "nativeAction")
        }
    }

    // MARK: - WKUIDelegate
    
    // 读取JS的 window.alert() 弹框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("====alert=", message)
        // 拦截、并处理 alert()
        let alertVc = UIAlertController(title: "温馨提示", message: message, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "知道了", style: .cancel) { _ in
            completionHandler()
        }
        alertVc.addAction(sureAction)
        self.present(alertVc, animated: true, completion: nil)
    }
    
    // 读取JS的 window.confirm() 确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        // 拦截、并处理 confirm()
        print("====confirm=", message)
    }
    
    // 读取JS的 widnow.prompt() 文本输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        // 拦截、并处理 prompt()
        print("====prompt=", prompt)
    }
    
    // MARK: - WKScriptMessageHandler
    
    // 从此方法中响应 JS 发送的消息
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // WKScriptMessage：封装JS代码发送消息的对象
        
        print("消息名称：\(message.name), 消息参数：\(message.body)")
        if message.name == "nativeAction" {
            // 根据JS发送的相应消息来调用swift中的方法
        }
        
    }
    
    // MARK: - WKNavigationDelegate
    
    // 对一次action来决定是否允许跳转是否允许这个导航
    // 如下拦截链接：<a href="darkangel://smsLogin?username=12323123&code=892845">短信验证登录</a>
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // 跳转类型
        switch navigationAction.navigationType {
        case .linkActivated:
            print("===navigation action 点击 href 链接")
        case .formSubmitted:
            print("===navigation action 提交表单")
        case .backForward:
            print("===navigation action 对帧的下一项或上一项加载")
        case .reload:
            print("===navigation action 重新加载")
        case .formResubmitted:
            print("===navigation action 重新提交表单")
        default:
            print("===navigation action other")
        }
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            self.navigationItem.title = webView.title
            return
        }
        
        // 1、判断URL是否符合自定义的URL Scheme
        if (url.scheme ?? "") == "darkangel" {
            // 2、根据不同的业务，来执行对应的操作，且获取参数
            if (url.host ?? "") == "smsLogin" {
                print("===短信验证码登陆，参数为：", url.query ?? "")
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
                self.navigationItem.title = webView.title
            }
            
        } else {
            decisionHandler(.allow)
            self.navigationItem.title = webView.title
        }
    }
    
    // 知道返回内容之后，是否允许加载，允许加载
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        // 根据response来决定，是否允许跳转，允许与否都需要调用decisionHandler
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if webView.url?.absoluteString.hasPrefix("itms-appss://itunes.apple.com") ?? false {
            UIApplication.shared.open(webView.url!, options: [:]) { res in
                print("==", res)
            }
        }
    }
    
    // 开始加载网页
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    // 网页加载成功
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // 只有在页面加载完成后才能在实现 Swift 调用 JS 的方法，sayHello()是JS的方法
        webView.evaluateJavaScript("sayHello('WebView你好！')") { (result, err) in
            print(result, err.debugDescription)
        }
        
        webView.evaluateJavaScript("document.title") { str, error in
            if let str = str as? String {
                print("======", str)
                self.navigationItem.title = str
            }
        }
    }
    
    // 网页加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // 当WKWebView加载的网页占用内存过大时，会出现白屏现象，刷新一下就好了
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }

}
