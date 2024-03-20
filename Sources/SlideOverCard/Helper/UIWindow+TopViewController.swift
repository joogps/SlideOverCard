//
//  UIWindow+TopViewController.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 20/03/24.
//

import UIKit

extension UIWindow {
    internal func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
