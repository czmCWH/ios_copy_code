import UIKit

class KDCountryCodeCell: UITableViewCell {

    static let reuseIdentifier = "KDCountryCodeCell"
    
    var titleLabel: UILabel!
    var codeLabel: UILabel!
    
    var model: KDCountryCodeModel? {
        didSet {
            guard let model = model else {
                return
            }
            
            titleLabel.text = model.countryName
            codeLabel.text = "+" + model.phoneCode
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(0xFFFFFF)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.text = "null"
        self.contentView.addSubview(titleLabel)
        
        codeLabel = UILabel()
        codeLabel.font = UIFont.systemFont(ofSize: 14)
        codeLabel.textColor = .black
        codeLabel.textAlignment = .right
        codeLabel.text = "null"
        self.contentView.addSubview(codeLabel)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(12)
            $0.width.equalToSuperview().multipliedBy(0.6)
            $0.centerY.equalToSuperview()
        }
        
        codeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview()
        }
    }
}
