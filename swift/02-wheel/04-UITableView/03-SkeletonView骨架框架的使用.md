# SkeletonView框架的使用

具体可以参考：https://www.jianshu.com/p/b0f1714506a6


```
import SkeletonView

func initViews() {
    tableView = UITableView(frame: .zero, style: .grouped)
    // 开始可以显示骨架
    tableView.isSkeletonable = true
}

/// 在加载数据时 显示 tableView 骨架
func showTablePlaceItem() {
    self.tableView.showAnimatedSkeleton()
}

/// 数据加载完成时，隐藏 tableView 骨架
func hiddenTablePlaceItem() {
    self.tableView.hideSkeleton()
}

class TableViewCell: UITableViewCell {
	var imgView: UIImageView!
    var nameLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView.isSkeletonable = true
        nameLabel.isSkeletonable = true
        nameLabel.skeletonTextNumberOfLines = 2
    }
}
```