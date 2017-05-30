//
//  UIImageViewHelper.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import AFNetworking
extension UIImageView {
    
    func loadImage(urlString: String){
        let url = NSURL(string: urlString)
        if url == nil {
            return
        }
        self.setImageWith(url! as URL)
    }
}

