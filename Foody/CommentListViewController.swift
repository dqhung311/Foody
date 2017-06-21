//
//  CommentListViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/21/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CommentListViewController: UIViewController {
    
    var productItem  = ProductItem()
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelProductName.text = productItem.name
        labelProductAddress.text = productItem.address
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
  
}

extension CommentListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentListViewCell", for: indexPath)
        return cell
    }
}

