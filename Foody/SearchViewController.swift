//
//  SearchViewController.swift
//  Foody
//
//  Created by Le NK on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var recentViewBtn: UIButton!
    @IBOutlet weak var recentOrderBtn: UIButton!
    @IBOutlet weak var searchedBtn: UIButton!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    let productService = ProductService()
    var productList  = [ProductItem]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recentViewBtn.layer.borderColor = UIColor.gray.cgColor
        self.recentOrderBtn.layer.borderColor = UIColor.gray.cgColor
        self.searchedBtn.layer.borderColor = UIColor.gray.cgColor
        productService.fetchAllProduct(query: ""){ [weak self] (productList, error) in
            self?.productList = productList
            DispatchQueue.main.async {
                self?.searchResultTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let height: CGFloat = 44
            return height
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")
        if let cell = cell as? SearchCell {
            cell.loadCell(data: productList[indexPath.row])
        }
        return cell!
    }

}
