//
//  ViewController.swift
//  iOSInterviewDemos
//
//  Created by Yi Zhang on 2021/4/25.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: IndexedTableView?
    var button: UIButton?
    var dataSource: [Int] = []

    var hasChanged: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView = IndexedTableView(frame: CGRect(x: 0, y: 60, width: view.frame.size.width, height: view.frame.size.height - 60))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.indexedDataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView!)

        button = UIButton(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 40))
        button?.backgroundColor = .red
        button?.setTitle("reloadTable", for: .normal)
        button?.addTarget(self, action: #selector(self.doAction), for: .touchUpInside)
        view.addSubview(button!)

        for i in 0...100 {
            dataSource.append(i)
        }
    }

    @objc func doAction() {
        tableView?.reloadData()
        print("reload")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, IndexedTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(dataSource[indexPath.row])

        return cell
    }

    func indexTitlesForIndexTableView(_ tableView: UITableView) -> [String] {
        if hasChanged {
            hasChanged = false
            return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]
        }

        hasChanged = true
        return["A", "B", "C", "D", "E", "F"]
    }
}
