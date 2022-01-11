
import UIKit

class SidePositionCell: UITableViewCell {

    static let reuseIdentifier = "SidePositionCell"
    
    var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
        titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .natural
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }

}
