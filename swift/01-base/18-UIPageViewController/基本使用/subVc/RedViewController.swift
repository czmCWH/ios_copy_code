//
//  RedViewController.swift
//  test01
//
//  Created by czm on 2021/12/2.
//

import UIKit

class RedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = UIColor.white
        table.tableHeaderView = UIView()
        table.tableFooterView = UIView()
        table.rowHeight = 88
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("==== red Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("==== red Will Disappear")
    }
    

    // MARK: - Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.red
        cell.textLabel?.text = "red===\(indexPath.row)"
        return cell
    }
        
    
}
