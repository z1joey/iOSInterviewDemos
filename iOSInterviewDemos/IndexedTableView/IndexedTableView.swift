//
//  IndexedTableView.swift
//  iOSInterviewDemos
//
//  Created by Yi Zhang on 2021/4/26.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

protocol IndexedTableViewDataSource: class {
    func indexTitlesForIndexTableView(_ tableView: UITableView) -> [String]
}

class IndexedTableView: UITableView {
    public weak var indexedDataSource: IndexedTableViewDataSource?

    private var containerView: UIView?
    private var reusePool: ViewReusePool?

    override func reloadData() {
        super.reloadData()

        if containerView == nil {
            containerView = UIView()
            containerView?.backgroundColor = .white

            superview?.insertSubview(containerView!, aboveSubview: self)
        }

        if reusePool == nil {
            reusePool = ViewReusePool()
        }

        reusePool?.reset()

        reloadIndexedBar()
    }

    func reloadIndexedBar() {
        guard let titles = indexedDataSource?.indexTitlesForIndexTableView(self) else {
            return
        }

        if titles.count <= 0 {
            containerView?.isHidden = true
            return
        }

        let btnWidth: CGFloat = 60
        let btnHeight: CGFloat = frame.size.height / CGFloat(titles.count)

        var button: UIButton?

        for (index, title) in titles.enumerated() {
            if let btn = reusePool?.dequeueReusableView() as? UIButton {
                button = btn
                print("Reused the button")
            } else {
                button = UIButton()
                button?.backgroundColor = .white

                reusePool?.addUsingView(button)
                print("Created a new button")
            }

            containerView?.addSubview(button!)
            button?.setTitle(title, for: .normal)
            button?.setTitleColor(.black, for: .normal)
            button?.frame = CGRect(
                x: 0,
                y: CGFloat(index) * btnHeight,
                width: btnWidth,
                height: btnHeight)

            containerView?.frame = CGRect(
                x: frame.origin.x + frame.size.width - btnWidth,
                y: frame.origin.y,
                width: btnWidth,
                height: frame.size.height)
        }
    }
}
