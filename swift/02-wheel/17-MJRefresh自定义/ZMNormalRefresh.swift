
import UIKit
import MJRefresh

//参考： https://github.com/JoanKing/JKSwiftRefresh

class ZMRefreshNormalHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        
        // 隐藏时间
        setTitle("下拉可以刷新", for: .idle)
        setTitle("松开立即刷新", for: .pulling)
        setTitle("正在刷新数据中...", for: .refreshing)
        
        // 修改状态 Label 字体、颜色
        stateLabel!.font = UIFont.systemFont(ofSize: 12)
        stateLabel!.textColor = UIColor.red
        
        // 修改时间 Label 字体、颜色
        lastUpdatedTimeLabel!.textColor = UIColor.blue
        lastUpdatedTimeLabel!.font = UIFont.systemFont(ofSize: 13)
        
        // 隐藏时间
         lastUpdatedTimeLabel!.isHidden = true
        // 隐藏所有状态提示 Label
        // stateLabel!.isHidden = true
    }
}

class ZMRefreshAutoNormalFooter: MJRefreshAutoNormalFooter {
    
    override func prepare() {
        super.prepare()
        
        setTitle("上拉加载更多", for: .idle)
        setTitle("松手开始加载", for: .pulling)
        setTitle("数据加载中...", for: .refreshing)
        setTitle("没有更多数据啦～", for: .noMoreData)
        
        // 设置字体
        stateLabel?.font = UIFont.systemFont(ofSize: 14)
        stateLabel?.textColor = UIColor.red
        
        // 隐藏刷新状态的文字
//        isRefreshingTitleHidden = true
        // 是否自动加载（默认为true，即表格滑到底部就自动加载）
//        isAutomaticallyRefresh = true
        
    }
}



do {
    tableView.mj_header = ZMRefreshNormalHeader(refreshingBlock: {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            tableView.mj_header?.endRefreshing()
        }
    })
    
    tableView.mj_footer = ZMRefreshAutoNormalFooter(refreshingBlock: {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            tableView.mj_footer?.endRefreshing()
        }
    })
}
