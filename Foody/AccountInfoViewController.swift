//
//  AccountInfoViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/5/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController {
    
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var viewLoginBacground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        viewLoginBacground.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        
        
               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
