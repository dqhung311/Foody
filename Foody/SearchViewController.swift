//
//  SearchViewController.swift
//  Foody
//
//  Created by Le NK on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
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
        productService.fetchProduct(strUrl: ""){ [weak self] (productList, error) in
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

}
