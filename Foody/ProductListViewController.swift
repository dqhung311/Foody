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
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setUIView()
        self.productListView.reloadData()
        
        //self.productListView.reloadData()
    
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
        self.performSegue(withIdentifier: "Home", sender: sender)
    }
    @IBAction func addProduct(_ sender: UIButton){
        if checkLogin() {
          self.performSegue(withIdentifier: "AddProduct", sender: sender)
        }else{
            let storyboard = UIStoryboard(name: "Second", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoard")
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? ProductDetailController {
        svc.productItem = self.productItemInfo
        }
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
             height = (self.view.frame.size.height * 0.5)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell")
            if let cell = cell as? ProductListCell {
                //height = 200 + cell.picturePreview.frame.height
            }
        }
      return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let str = "&"
        //if query.range(of:"?") != nil{
        //    str = ""
        //}
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
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ProductDetail", sender: self)
            }
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
                
                
                //cell.viewCommentList.frame.size.height = 200
                //cell.contentView.addSubview(cell.viewCommentList)
                cell.loadCell(data: dataProduct)
                /*let y_position = Int(cell.picturePreview.frame.size.height) + 70
                for i in 0..<4 {
                    let label = UILabel(frame: CGRect(x: 0, y: Int(i * y_position), width: 100, height: 20))
                    label.text = "dqhung"
                    label.font = UIFont(name: label.font.fontName, size: 12)
                    label.sizeToFit()
                    label.numberOfLines = 1
                    cell.contentView.addSubview(label)
                }*/
                
            }
            return cell!
        }
        
    }
}

