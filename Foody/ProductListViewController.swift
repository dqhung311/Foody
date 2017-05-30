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
    
    let urlString = "http://anphatkhanh.vn/foody/json.php"
    var provinceList = [ProductProvince]()
    var categoryList = [ProductCategory]()
    var productList  = [ProductItem]()
    let foodyAPI = FoodyAPI()
    
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
        self.getJSON(url: urlString)
        DispatchQueue.main.async {
            self.productListView.reloadData()
            
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
        
    func getJSON(url: String) {
        let manager = AFHTTPSessionManager()
        manager.get(
            url,
            parameters: nil,
            success:
            {
                (operation, responseObject) in
                
                if let jsonDict = responseObject as? [String: Any] {
                    
                    if let product = jsonDict["product"] as? [[String:Any]] {
                        
                        self.productList = []
                        for p in product{
                            
                            let item = ProductItem()
                            
                            if let id = p["id"] as? String {
                                item.id = id
                            }
                            if let name = p["name"] as? String {
                                item.name = name
                            }
                            if let code = p["code"] as? String {
                                item.code = code
                            }
                            if let address = p["address"] as? String {
                                item.address = address
                            }
                            if let urlphoto = p["preview_image"] as? String {
                                item.urlphoto = urlphoto
                            }
                            if let score = p["score"] as? String {
                                item.score = score
                            }
                            self.productList.append(item)
                        }
                    }
                    
                    
                    if let province = jsonDict["province"] as? [[String:Any]] {
                        
                            self.provinceList = []
                            for p in province{
                                let item = ProductProvince()
                                
                                if let id = p["id"] as? String {
                                    item.id = id
                                }
                                if let name = p["name"] as? String {
                                    item.name = name
                                }
                                if let code = p["code"] as? String {
                                    item.code = code
                                }
                                self.provinceList.append(item)
                                
                            }
                        
                    }
                    
                    if let category = jsonDict["category"] as? [[String:Any]] {
                        
                        self.categoryList = []
                        for p in category{
                            let item = ProductCategory()
                            if let id = p["id"] as? String {
                                item.id = id
                            }
                            if let name = p["name"] as? String {
                                item.name = name
                            }
                            if let code = p["code"] as? String {
                                item.code = code
                            }
                            if let urlphoto = p["urlphoto"] as? String {
                                item.urlphoto = urlphoto
                            }
                            self.categoryList.append(item)
                            
                        }
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    self.productListView.reloadData()
                }
                
        },
            failure:
            {
                (operation, error) in
                print("Error: " + error.localizedDescription)
        })
        
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

