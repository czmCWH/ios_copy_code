//
//  UserModel.swift
//  test01
//
//  Created by czm on 2021/7/28.
//
/* 使用方式：
 
 获取单例归档对象
 let mod = UserModel.shared
 mod.xxx 
 
 存储归档对象
 UserModel.saveArchiver()

 清空归档对象
 UserModel.clearArchiver()
 */

import UIKit

class UserModel: NSObject, NSCoding {
    
    static let shared: UserModel = {
        guard let dataModel = NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.getSavePath()) as? UserModel else {
            return UserModel()
        }
        return dataModel
    }()
    
    var orderName:String = ""
    var userName:String = ""
    
    /// 归档存储对象
    static func saveArchiver() {
        NSKeyedArchiver.archiveRootObject(UserModel.shared, toFile: getSavePath())
    }
    
    /// 清理归档对象
    static func clearArchiver() {
        UserModel.shared.orderName = ""
        UserModel.shared.userName = ""
        self.saveArchiver()
    }
    
    /// 重写初始化方法，保证只能通过 shared 初始化
    private override init() { }
    
    /// 归档,写文件
    func encode(with coder: NSCoder) {
        coder.encode(self.orderName, forKey:"orderName")
        coder.encode(self.userName, forKey: "userName")
    }
    
    /// 解档方法,读文件
    required init?(coder: NSCoder) {
        super.init()
        self.orderName = coder.decodeObject(forKey: "orderName") as! String
        self.userName = coder.decodeObject(forKey: "userName") as! String
    }
    
    /// 获取归档文件存储的位置
    private static func getSavePath() -> String {
        let cacheDir:String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        let localPath:String = cacheDir.appending("UserModel.plist")
        return localPath
    }
    
}
