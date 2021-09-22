//
//  SDETabBarViewController.swift
//  CustomContainerVCTransition
//
//  Created by seedante on 15/12/29.
//  Copyright © 2015年 seedante. All rights reserved.
//

import UIKit

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}


class SDETabBarViewController: SDEContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure Interactive Transiton
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pangesture)
    }
    
    var lastSelectedIndex: Int = NSNotFound
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer){

        guard let viewControllers = self.viewControllers,
              viewControllers.count > 1,
              let delegate = containerTransitionDelegate as? SDEContainerViewControllerDelegate else {
            return
        }
        
        let translationX = gesture.translation(in: view).x
        let translationAbs = translationX > 0 ? translationX : -translationX
        let progress = translationAbs / view.frame.width
        switch gesture.state{
        case .began:
            interactive = true
            lastSelectedIndex = selectedIndex
            
        case .changed:
            /*
             原来：
             此处是使用的速度，而不是偏移量，并且放在了 begin 事件当中
             */
//            let velocityX = gesture.velocity(in: view).x
            debugPrint(translationX)
            if translationX < 0 {
                if lastSelectedIndex < viewControllers.count - 1 {
                    selectedIndex = lastSelectedIndex + 1
                }
                delegate.interactionController.updateInteractiveTransition(progress)
            } else if translationX > 0  {
                if lastSelectedIndex > 0{
                    selectedIndex = lastSelectedIndex - 1
                }
                delegate.interactionController.updateInteractiveTransition(progress)
            } else {
                delegate.interactionController.cancelInteractiveTransition()
            }
            
        case .cancelled, .ended:
            interactive = false
            if progress > 0.6{
                delegate.interactionController.finishInteractiveTransition()
            }else{
                delegate.interactionController.cancelInteractiveTransition()
            }
        default: break
        }
    }
}
