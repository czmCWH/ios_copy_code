class ExampleCell: UITableViewCell {

    static let reuseIdentifier = "ExampleCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
