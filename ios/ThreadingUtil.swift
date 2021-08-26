//
//  ThreadingUtil.swift
//  ZendriveNative
//
//  Created by Mert Ozyilmaz on 23.10.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit

class ThreadingUtil: NSObject {
    public static func synchronized(_ lock: Any, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}
