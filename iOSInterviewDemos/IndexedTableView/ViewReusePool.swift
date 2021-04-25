//
//  ViewReusePool.swift
//  iOSInterviewDemos
//
//  Created by Yi Zhang on 2021/4/26.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

class ViewReusePool: NSObject {
    var waitUsedQueue: NSMutableSet
    var usingQueue: NSMutableSet

    override init() {
        waitUsedQueue = NSMutableSet()
        usingQueue = NSMutableSet()
    }

    func dequeueReusableView() -> UIView? {
        let anyObject = waitUsedQueue.anyObject()

        if let view = anyObject as? UIView {
            waitUsedQueue.remove(view)
            usingQueue.add(view)
            return view
        } else {
            return nil
        }
    }

    func addUsingView(_ view: UIView?) {
        guard view != nil else { return }

        usingQueue.add(view!)
    }

    func reset() {
        while let view = usingQueue.anyObject() as? UIView {
            usingQueue.remove(view)
            waitUsedQueue.add(view)
        }
    }
}
