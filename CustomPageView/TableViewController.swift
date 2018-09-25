//
//  TableViewController.swift
//  CustomPageView
//
//  Created by Hakutaku on 2018/09/25.
//  Copyright © 2018年 Hakutaku. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    var tableName: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    func inject(tableName: String) {
        self.tableName = tableName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TableViewController: UITableViewDelegate {
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = tableName
        return cell
    }
}
