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
    @IBOutlet weak var boundButtonMenu: UIView!
    
    var viewCurrent: String = ""
    var query: String = ""
    
    var provinceList = [ProductProvince]()
    var categoryList = [ProductCategory]()
    var productList  = [ProductItem]()
    
    let productService = ProductService()
    let categoryService = CategoryService()
    let provinceService = ProvinceService()
    
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
        
        productService.fetchProduct(strUrl: ""){ [weak self] (productList, error) in
            self?.productList = productList
            DispatchQueue.main.async {
                self?.productListView.reloadData()
            }
        }
        categoryService.fetchCategory(){ [weak self] (categoryList, error) in
            self?.categoryList = categoryList
            DispatchQueue.main.async {
                self?.productListView.reloadData()
            }
           
        }
        provinceService.fetchProvince(){ [weak self] (provinceList, error) in
            self?.provinceList = provinceList
            DispatchQueue.main.async {
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
        let myViews = boundButtonMenu.subviews.filter{$0 is UIView}
        for view in myViews {
            let viewbutton = view.subviews.filter{$0 is UIButton}
            for btn in viewbutton{
                if let item = btn as? UIButton
                {
                    item.setTitleColor(UIColor.darkGray, for: .normal)
                }
            }
        }
        sender.setTitleColor(UIColor.red, for: .normal)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var str = "?"
        if query.range(of:"?") != nil{
            str = "&"
        }
        
        if(viewCurrent == tabCategory){
            query += "\(str)catID=\(categoryList[indexPath.row].id)"
            self.viewCurrent = tabProduct
            productService.fetchProduct(strUrl: "http://anphatkhanh.vn/foody/product/\(query)"){ [weak self] (productList, error) in
                self?.productList = productList
                DispatchQueue.main.async {
                    self?.productListView.reloadData()
                }
            }
            btnCategory.setTitle(categoryList[indexPath.row].name, for: .normal)
        }
        if(viewCurrent == tabProvince){
            query += "\(str)provinceID=\(provinceList[indexPath.row].id)"
            self.viewCurrent = tabProduct
            productService.fetchProduct(strUrl: "http://anphatkhanh.vn/foody/product/\(query)"){ [weak self] (productList, error) in
                self?.productList = productList
                DispatchQueue.main.async {
                    self?.productListView.reloadData()
                }
            }
            btnProvince.setTitle(provinceList[indexPath.row].name, for: .normal)
        }
        //print(query)
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
                //cell.labelCategoryName.text = "Danh muc"
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

