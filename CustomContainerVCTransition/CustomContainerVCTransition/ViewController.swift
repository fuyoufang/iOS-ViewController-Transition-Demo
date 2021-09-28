//
//  ViewController.swift
//  CustomContainerVCTransition
//
//  Created by seedante on 15/12/24.
//  Copyright © 2015年 seedante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if label.superview == nil{
            label.text = title
            label.sizeToFit()
            view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraint(NSLayoutConstraint(item: self.view!, attribute: .centerX, relatedBy: .equal, toItem: label, attribute: .centerX, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: self.view!, attribute: .centerY, relatedBy: .equal, toItem: label, attribute: .centerY, multiplier: 1, constant: 0))
        }
        
    }
}

