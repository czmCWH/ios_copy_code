
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

---------------------------设置一个子view的四边内边距据父view都为20

button.snp.makeConstraints { (make) in
    make.edges.equalTo(bgView).inset(UIEdgeInsetsMake(20, 20, 20, 20))
    }

//上面代码和注释代码等同
//        box.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(superview).offset(20)
//            make.left.equalTo(superview).offset(20)
//            make.bottom.equalTo(superview).offset(-20)
//            make.right.equalTo(superview).offset(-20)
//        }



------------ 设置每个 stack View的 子subView 等size 排列

let stackView = UIStackView()
stackView.axis = .horizontal
stackView.alignment = .fill
stackView.distribution = .fillEqually
stackView.spacing = 15
return stackView
