
import UIKit

class ClipTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUI() {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        self.contentView.addSubview(view)
        
        view.snp.makeConstraints { 
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
        }
    }
    
    func setupConstraints() {
        
    }

}
