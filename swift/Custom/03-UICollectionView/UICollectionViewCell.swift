
class ExampleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ExampleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
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
