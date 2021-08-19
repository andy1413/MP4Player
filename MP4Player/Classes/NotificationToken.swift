//
//  File.swift
//  PrimeStory
//
//  Created by anddy on 2021/2/8.
//  Copyright © 2021 chenyungui. All rights reserved.
//

import Foundation

class NotificationToken {
    let center: NotificationCenter
    let token: NSObjectProtocol
    
    init(center: NotificationCenter, token: NSObjectProtocol) {
        self.center = center
        self.token = token
    }
    
    deinit {
        center.removeObserver(token)
    }
}

extension NotificationCenter {
    func addObserver(
        name: Notification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping (Notification) -> Void) -> NotificationToken {

        let token: NSObjectProtocol = addObserver(forName: name, object: obj, queue: queue, using: block)
        return .init(center: self, token: token)
    }
    
    func addObserver(
        forName name: Notification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping (Notification) -> Void) -> NotificationToken {
        
        let token: NSObjectProtocol = addObserver(forName: name, object: obj, queue: queue, using: block)
        return .init(center: self, token: token)
    }
}
