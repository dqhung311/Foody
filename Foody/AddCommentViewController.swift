//
//  AddCommentViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/14/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {
    
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var viewAddComment: UIView!
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    var productItem  = ProductItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.getId())
        //self.viewAddComment.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        labelProductName.text = productItem.name
        labelProductAddress.text = productItem.address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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
