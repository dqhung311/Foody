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
    var refreshControl: UIRefreshControl!
    let commentService = CommentService()
    var commentList = [Comments]()
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAddress: UILabel!
    @IBOutlet weak var commentListView: UITableView!
    
    @objc func pullToRefreshHandler() {
        // refresh table view data here
        self.loadData()
        self.refreshControl.endRefreshing()
    }
    func loadData(){
        commentService.fetchAll("productID=\(productItem.id)"){ [weak self] (commentList, error) in
            self?.commentList = commentList
            DispatchQueue.main.async {
                self?.commentListView.reloadData()
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        labelProductName.text = productItem.name
        labelProductAddress.text = productItem.address
        commentListView.estimatedRowHeight = 44.0
        commentListView.rowHeight = UITableViewAutomaticDimension
        commentListView.separatorStyle = .none
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self,
                                      action: #selector(ProductListViewController.pullToRefreshHandler),
                                      for: .valueChanged)
        
        self.commentListView.addSubview(self.refreshControl)
        
        self.loadData()
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentListViewCell", for: indexPath)
        if let cell = cell as? CommentListViewCell {
        
            let data = commentList[indexPath.row]
            cell.loadCell(data: data)
            
        }
        return cell
    }
}

