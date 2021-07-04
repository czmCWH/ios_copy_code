//
//  KDAppleLoginManager.swift
//  Kiddos
//
//  Created by michael on 2021/6/21.
//
// https://developer.apple.com/documentation/sign_in_with_apple
// 代码示例可参考：https://developer.apple.com/documentation/sign_in_with_apple/implementing_user_authentication_with_sign_in_with_apple
// https://juejin.cn/post/6844903914051993607


import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
class KDAppleLoginManager: NSObject {
    
    weak var controller: UIViewController?
    var authAppleSuccess: ((String, String) -> ())?
    
    func loginWithApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 通过iCloud密钥链凭据实现 Apple 登录，如果未设置请忽略。
    private func performExistingAccountSetupFlows() {
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}

@available(iOS 13.0, *)
extension KDAppleLoginManager: ASAuthorizationControllerDelegate {
    
    /// 身份验证成功，授权控制器调用此函数
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 在你的系统中创建一个账户
            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
            guard let identityToken = appleIDCredential.identityToken,
                  let authorizationCode = appleIDCredential.authorizationCode else { return  }
            
            guard let token = String.init(data: identityToken, encoding: .utf8),
                  let _ = String.init(data: authorizationCode, encoding: .utf8)  else { return }
            
//            print("===授权成功===", userIdentifier, "\n", token, "\n", code)
            self.authAppleSuccess?(userIdentifier, token)
//            self.postNetwork(client_id: "com.czm.test01", client_secret: code, grant_type: "authorization_code")
        
        case _ as ASPasswordCredential:
            // 使用现有的 iCloud 密钥链凭据登录，如果不支持可忽略
//            let username = passwordCredential.user
//            let password = passwordCredential.password
            break
        default:
            break
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        var errorStr : String?
        switch (error as NSError).code {
        case ASAuthorizationError.canceled.rawValue :
            errorStr = "用户取消了授权请求"
        case ASAuthorizationError.failed.rawValue :
            errorStr = "授权请求失败"
        case ASAuthorizationError.invalidResponse.rawValue :
            errorStr = "授权请求无响应"
        case ASAuthorizationError.notHandled.rawValue :
            errorStr = "未能处理授权请求"
        case ASAuthorizationError.unknown.rawValue :
            errorStr = "授权请求失败原因未知"
        default:
            break
        }
        if let str = errorStr {
            // 回调使用 error
            print("=====", str)
        }
    }
}

@available(iOS 13.0, *)
extension KDAppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    /// 在此窗口中，向用户显示使用 Apple 登录的内容
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
        return UIApplication.shared.keyWindow ?? ASPresentationAnchor()
//        return AppTool.currentVC()?.view.window  ?? ASPresentationAnchor()
//        return self.controller!.view.window!
    }
}

