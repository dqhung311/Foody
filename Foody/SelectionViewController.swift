//
//  SelectionViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/9/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    var viewCurrent: String = ""
    var provinceList = [ProductProvince]()
    var categoryList = [ProductCategory]()
    let tabCategory = Config().getTabCategory()
    let tabProvince = Config().getTabProvince()
    let categoryService = CategoryService()
    let provinceService = ProvinceService()
    
    var categorySelected: String = ""
    var provinceSelected: String = ""
    
    var indexCategorySelected: Int = 0
    var indexProvinceSelected: Int = 0
    
    @IBOutlet weak var tableViewSelection: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryService.fetchAllCategory(){ [weak self] (categoryList, error) in
            self?.categoryList = categoryList
            DispatchQueue.main.async {
                self?.tableViewSelection.reloadData()
            }
            
        }
        provinceService.fetchProvince(){ [weak self] (provinceList, error) in
            self?.provinceList = provinceList
            DispatchQueue.main.async {
                self?.tableViewSelection.reloadData()
            }
            
        }
        
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func disMist(_ sender: Any?){
        
    }
      
}

extension SelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(viewCurrent == tabCategory){
            indexCategorySelected = indexPath.row
        }else if(viewCurrent == tabProvince){
            indexProvinceSelected = indexPath.row
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewCurrent == tabCategory){
            return categoryList.count
        }else if(viewCurrent == tabProvince){
            return provinceList.count
        }
        return 5
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell")
            cell?.textLabel?.text = "adsadsa"
            return cell!
        }
        
    }
}
