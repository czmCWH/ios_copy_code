
shopItemView.snp.makeConstraints {
    
    if #available(iOS 11.0, *) {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
    } else {
        $0.top.equalTo(self.topLayoutGuide.snp.top).offset(40)
    }
    $0.leading.bottom.equalToSuperview()
    $0.width.equalTo(105)
    if #available(iOS 11.0, *) {
        $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
    } else {
        $0.bottom.equalToSuperview().offset(-10)
    }
}
