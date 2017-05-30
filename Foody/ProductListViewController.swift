//
//  ProductListViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/24/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import AFNetworking

class ProductListViewController: UIViewController{
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var btnLatest: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnProvince: UIButton!
    
    @IBOutlet weak var productListView: UITableView!
    
    
    var viewCurrent: String = ""
    
    //let urlString = "http://anphatkhanh.vn/foody/json.php"
    var provinceList = [ProductProvince]()
    var categoryList = [ProductCategory]()
    var productList  = [ProductItem]()
    
    let productService = ProductService()
    
    let tabProduct = Config().getTabProduct()
    let tabCategory = Config().getTabCategory()
    let tabProvince = Config().getTabProvince()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        //self.getJSON(url: urlString)
        
        
        productService.getAllProduct(urlString: "http://anphatkhanh.vn/foody/json.php"){ [weak self] (productList, error) in
            self?.productList = productList
            DispatchQueue.main.async {
                print(productList.count)
                self?.productListView.reloadData()
            }
        }
        
    
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.performSegue(withIdentifier: "Home", sender: nil)
    }

    
    @IBAction func tabToChangeView(_ sender: UIButton){
        if (sender === btnLatest){
            self.viewCurrent = tabProduct
        }
        if (sender === btnCategory){
            self.viewCurrent = tabCategory
        }
        if (sender === btnProvince){
            self.viewCurrent = tabProvince
        }
        
        self.productListView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 44
        if(viewCurrent == tabProduct || viewCurrent == ""){
            height = 250
        }
        return height
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewCurrent == tabCategory){
            return categoryList.count
        }else if(viewCurrent == tabProvince){
            return provinceList.count
        }else{
            return productList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(viewCurrent == tabCategory){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell")
            if let cell = cell as? CategoryListCell {
                let dataCategory = categoryList[indexPath.row]
                cell.loadCell(data: dataCategory)
            }
            return cell!
        }else if(viewCurrent == tabProvince){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProvinceListCell")
            if let cell = cell as? ProvinceListCell {
                let dataProvince = provinceList[indexPath.row]
                cell.loadCell(data: dataProvince)
            }
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell")
            if let cell = cell as? ProductListCell {
                
                let dataProduct = productList[indexPath.row]
                cell.loadCell(data: dataProduct)
            }
            return cell!
        }
        
    }
}

