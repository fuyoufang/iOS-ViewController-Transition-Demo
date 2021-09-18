//
//  ViewController.swift
//  CustomPresentationTransition
//
//  Created by seedante on 15/12/15.
//  Copyright © 2015年 seedante. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController{
    var index = 0
    let presentTransitionDelegate = SDEModalTransitionDelegate()
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.alpha = 0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let widthContraint = inputTextField.constraints.filter({constraint in
            constraint.identifier == "Width"
            }).first
        widthContraint?.constant = view.frame.width * 2 / 3
        
        UIView.animate(withDuration: 0.3, animations: {
            self.dismissButton.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if self.navigationController == nil {
            
            // 获取StoryBoard对象（这里使用的是默认的主bundle中的文件）
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            // 使用ID在StoryBoard对象中获取并初始化新的ViewController
            let toVC: PresentedViewController = storyBoard.instantiateViewController(withIdentifier:  "PresentedVC") as! PresentedViewController
            toVC.index = vindex
            vindex += 1
            
            if toVC.index % 2 == 0 {
                let nav = UINavigationController(rootViewController: toVC)
                // nav.transitioningDelegate = toVC.presentTransitionDelegate
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true, completion: nil)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dismiss(animated: true, completion: nil)
//                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                
            } else {
                present(toVC, animated: true, completion: nil)

            }
//        }
//        else {
//            dismiss(animated: true, completion: nil)
//        }
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
//        var applyTransform = CGAffineTransform( rotationAngle: 3 * CGFloat(M_PI))
//        applyTransform = applyTransform.scaledBy(x: 0.1, y: 0.1)
//
//        let widthContraint = inputTextField.constraints.filter({constraint in
//            constraint.identifier == "Width"
//        }).first
//        widthContraint?.constant = 0
//
//        UIView.animate(withDuration: 0.4, animations: {
//            self.dismissButton.transform = applyTransform
//            self.view.layoutIfNeeded()
//            }, completion: { _ in
//                self.dismiss(animated: true, completion: nil)
//        })
        
//        if self.navigationController == nil {
//
//            // 获取StoryBoard对象（这里使用的是默认的主bundle中的文件）
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            // 使用ID在StoryBoard对象中获取并初始化新的ViewController
//            let toVC: PresentedViewController = storyBoard.instantiateViewController(withIdentifier:  "PresentedVC") as! PresentedViewController
//            toVC.index = vindex
//            vindex += 1
//
//            if toVC.index == 0 || toVC.index == 2 {
//                let nav = UINavigationController(rootViewController: toVC)
//                //        nav.transitioningDelegate = toVC.presentTransitionDelegate
//                nav.modalPresentationStyle = .fullScreen
//                present(nav, animated: true, completion: nil)
//
//            } else if toVC.index == 1 {
//                present(toVC, animated: true, completion: nil)
//
//            }
//        } else {
        if let v = presentingViewController?.presentingViewController {
            v.dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
//
//        }
    }

}

var vindex = 0
