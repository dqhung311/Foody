//
//  SearchViewController.swift
//  Foody
//
//  Created by Le NK on 5/31/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var categoryBtn: UIButton!
    @IBOutlet weak var cityBtn: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    let productService = ProductService()
    var productList  = [ProductItem]()
    
    let categoryService = CategoryService()
    var categoryList  = [ProductCategory]()
    
    let provinceService = ProvinceService()
    var provinceList  = [ProductProvince]()
    
    
    var searchType: String = "name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryBtn.layer.borderColor = UIColor.gray.cgColor
        self.cityBtn.layer.borderColor = UIColor.gray.cgColor
        
        callprovince()
        callcategory()
        callproduct("")
        
    }

    func reloadtableview(){
        DispatchQueue.main.async {
            self.searchResultTableView.reloadData()
        }
    }
    
    func callproduct(_ callquery: String){
        productService.fetchAllProduct(query: callquery){ [weak self] (productList, error) in
            self?.productList = productList
            self?.reloadtableview()
        }
    }
    
    func callprovince(){
        provinceService.fetchProvince(){ [weak self] (provinceList, error) in
            self?.provinceList = provinceList
        }
    }
    
    func callcategory(){
        categoryService.fetchAllCategory(){ [weak self] (categoryList, error) in
            self?.categoryList = categoryList
        }
    }
    
    
    @IBAction func textEditSearch(_ sender: UITextField){
        self.callproduct("name=\(sender.text!)")
    }
    
    @IBAction func clickCatBtn(_ sender: UIButton){
        searchType = "category"
        reloadtableview()
    }
    
    @IBAction func clickProvinceBtn(_ sender: UIButton){
        searchType = "province"
        reloadtableview()
    }
    
    @IBAction func clickBack(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let height: CGFloat = 44
            return height
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var resCount:Int = 0
        if(searchType == "name"){
            resCount = productList.count
        }
        if(searchType == "category"){
            resCount = categoryList.count
        }
        if(searchType == "province"){
            resCount = provinceList.count
        }
        return resCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(searchType == "name"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")
            if let cell = cell as? SearchCell {
                cell.loadCell(data: productList[indexPath.row])
            }
            return cell!
        }
        if(searchType == "category"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell")
            if let cell = cell as? CategoryListCell {
                cell.loadCell(data: categoryList[indexPath.row])
            }
            return cell!
        }
        if(searchType == "province"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProvinceListCell")
            if let cell = cell as? ProvinceListCell {
                cell.loadCell(data: provinceList[indexPath.row])
            }
            return cell!
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searchType == "category"){
            searchType = "name"
            callproduct("cat=\(categoryList[indexPath.row].name)&name=\(searchTextField.text!)")
        }
        if(searchType == "province"){
            searchType = "name"
            callproduct("province=\(provinceList[indexPath.row].name)&name=\(searchTextField.text!)")
        }
    }
}
