//
//  UIViewControllerHelper.swift
//  Foody
//
//  Created by Le NK on 6/6/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func dismissAll(){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

