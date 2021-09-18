//
//  OverlayAnimationController.swift
//  CustomPresentationTransition
//
//  Created by seedante on 15/12/20.
//  Copyright © 2015年 seedante. All rights reserved.
//

import UIKit
protocol OverlayAnimationType {
//    var showTransitionDuration: TimeInterval { get set }
//    var hidenTransitionDuration: TimeInterval { get set }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    
}


extension OverlayAnimationController {
    
    /// 底部显示的动画
    class BottomAnimation: OverlayAnimationType {
        var showTransitionDuration: TimeInterval
        var hidenTransitionDuration: TimeInterval
        
        init(showTransitionDuration: TimeInterval, hidenTransitionDuration: TimeInterval) {
            self.showTransitionDuration = showTransitionDuration
            self.hidenTransitionDuration = hidenTransitionDuration
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let containerView = transitionContext.containerView
            guard let fromVC = transitionContext.viewController(forKey: .from),
                  let toVC = transitionContext.viewController(forKey: .to) else{
                return
            }
            
            let fromView = fromVC.view
            let toView = toVC.view
            
            if toVC.isBeingPresented{
                
                /// -----------
                let duration = showTransitionDuration
                
                let height = toVC.preferredContentSize.height
                // 1
                if let toView = toView {
                    containerView.addSubview(toView)
                    
                    toView.frame = CGRect(x: 0,
                                          y: containerView.bounds.size.height - height,
                                          width: containerView.bounds.size.width,
                                          height: height)
                }
                let toViewStartTransform = CGAffineTransform(translationX: 0, y: height)
                toView?.transform = toViewStartTransform

                UIView.animate(withDuration: duration,
                               delay: 0,
                               options: .curveEaseInOut) {
                    toView?.transform = .identity
                } completion: { _ in
                    // 2
                    let isCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!isCancelled)
                }
                
            }
            //Dismissal 转场中不要将 toView 添加到 containerView
            if fromVC.isBeingDismissed{
                
                // 处理 Dismissal 转场，
                // .custom 模式下不要将 toView 添加到 containerView，省去了上面标记1处的操作。
                let duration = showTransitionDuration
                guard let fromView = fromView else {
                    let isCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!isCancelled)
                    return
                }
                let height = toVC.preferredContentSize.height
//                var toVCP = toVC.presentedViewController
//                while toVCP != nil {
//                    toVCP?.view.transform = .identity
//                    toVCP = toVC.presentedViewController
//                }
                fromView.transform = .identity
                UIView.animate(withDuration: duration, animations: {
                    fromView.transform = CGAffineTransform(translationX: 0, y: height)
//                    toVCP = toVC.presentedViewController
//                    while toVCP != nil {
//                        let height = toVCP?.preferredContentSize.height ?? 0
//                        toVCP?.view.transform = CGAffineTransform(translationX: 0, y: height)
//                    }
                    
                }, completion: { _ in
                    //2
                    let isCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!isCancelled)
                })
            }
            
            
            
//            if !toVC.isBeingPresented && !fromVC.isBeingDismissed  {
//                let isCancelled = transitionContext.transitionWasCancelled
//                transitionContext.completeTransition(!isCancelled)
//            }
        }
    }
}



class OverlayAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animation = BottomAnimation(showTransitionDuration: 0.3, hidenTransitionDuration: 0.3)
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animation.animateTransition(using: transitionContext)

    }
}
