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
    
    var productItemInfo = ProductItem()
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUIView()
        
        productService.fetchAllProduct(query: ""){ [weak self] (productList, error) in
            self?.productList = productList
            DispatchQueue.main.async {
                self?.productListView.reloadData()
            }
        }
        categoryService.fetchAllCategory(){ [weak self] (categoryList, error) in
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
    
    func setUIView(){
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        
        let myViews = boundButtonMenu.subviews.filter{$0 is UIView}
        for view in myViews {
          view.backgroundColor = UIColor.clear
        }
        
        if(viewCurrent == tabProduct || viewCurrent==""){
            btnLatest.superview?.backgroundColor = UIColor.white
           
        }
        if(viewCurrent == tabCategory){
            btnCategory.superview?.backgroundColor = UIColor.white
        }
        if(viewCurrent == tabProvince){
            btnProvince.superview?.backgroundColor = UIColor.white
        }
        
     
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.performSegue(withIdentifier: "Home", sender: nil)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Ham lay screen moi .
        //let dest = segue.destination as? UIViewController
        let svc = segue.destination as! ProductDetailController
        svc.productItem = self.productItemInfo
        
        
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
        self.setUIView()
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
            productService.fetchAllProduct(query: query){ [weak self] (productList, error) in
                self?.productList = productList
                DispatchQueue.main.async {
                    self?.setUIView()
                    self?.productListView.reloadData()
                }
            }
            btnCategory.setTitle(categoryList[indexPath.row].name, for: .normal)
        }else if(viewCurrent == tabProvince){
            query += "\(str)provinceID=\(provinceList[indexPath.row].id)"
            self.viewCurrent = tabProduct
            productService.fetchAllProduct(query: query){ [weak self] (productList, error) in
                self?.productList = productList
                DispatchQueue.main.async {
                    self?.setUIView()
                    self?.productListView.reloadData()
                }
            }
            btnProvince.setTitle(provinceList[indexPath.row].name, for: .normal)
        }else{
            productItemInfo = productList[indexPath.row]
            self.performSegue(withIdentifier: "ProductDetail", sender: self)
        }
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

