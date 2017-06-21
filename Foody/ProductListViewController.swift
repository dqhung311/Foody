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
    var refreshControl: UIRefreshControl!
    var productItemInfo = ProductItem()
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @objc func pullToRefreshHandler() {
        // refresh table view data here
        self.loadData()
        self.refreshControl.endRefreshing()
    }
    
    
    func loadData(){
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
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self,
                                      action: #selector(ProductListViewController.pullToRefreshHandler),
                                      for: .valueChanged)
        
        self.productListView.addSubview(self.refreshControl)
        self.loadData()
    }
    
    func setUIView(){
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        let myViews = boundButtonMenu.subviews
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
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tabToAddProduct(_ sender: UIButton){
        if checkLogin() {
          self.performSegue(withIdentifier: "AddProduct", sender: sender)
        }else{
            self.goToStory("Second","LoginStoryBoard")
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? ProductDetailController {
            svc.productItem = self.productItemInfo
        }
        if let svc = segue.destination as? CommentListViewController {
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
    func onTabToViewDetail(tapGesture:UITapGestureRecognizer){
        
        self.productItemInfo = productList[(tapGesture.view?.tag)!]
        self.performSegue(withIdentifier: "ProductDetail", sender: self)
        
    }
    func onTabToViewComment(tapGesture:UITapGestureRecognizer){
        
        self.productItemInfo = productList[(tapGesture.view?.tag)!]
        self.performSegue(withIdentifier: "ShowCommentList", sender: self)
        
    }
    
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 44
        var heightComment: CGFloat = 0
        if(viewCurrent == tabProduct || viewCurrent == ""){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell")
            if let cell = cell as? ProductListCell {
               
               let dataProduct = productList[indexPath.row]
                if(dataProduct.total_comment <= 3){
                    heightComment = (35 * CGFloat(dataProduct.total_comment))
                }else{
                    heightComment =  105
                }
                height = (cell.picturePreview.frame.height  + cell.viewToolBox.frame.height + cell.viewTopTitle.frame.height + heightComment) + 10 //Contranit
            }
            
        }
      return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let str = "&"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath)
            let dataProduct = productList[indexPath.row]
            
            if let cell = cell as? ProductListCell {
                let tap = UITapGestureRecognizer(target: self, action: #selector(ProductListViewController.onTabToViewDetail))
                
                cell.viewTopTitle.tag = indexPath.row
                cell.viewTopTitle.isUserInteractionEnabled = true
                cell.viewTopTitle.addGestureRecognizer(tap)
                
                let tap2 = UITapGestureRecognizer(target: self, action: #selector(ProductListViewController.onTabToViewDetail))
                cell.picturePreview.tag = indexPath.row
                cell.picturePreview.isUserInteractionEnabled = true
                cell.picturePreview.addGestureRecognizer(tap2)
                
                let tap3 = UITapGestureRecognizer(target: self, action: #selector(ProductListViewController.onTabToViewComment))
                cell.viewCommentList.tag = indexPath.row
                cell.viewCommentList.isUserInteractionEnabled = true
                cell.viewCommentList.addGestureRecognizer(tap3)
                
                
                cell.loadCell(data: dataProduct)
                
                
            }
            return cell
        }
        
    }
}

