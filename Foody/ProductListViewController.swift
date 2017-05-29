//
//  ProductListViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/24/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import AFNetworking

class ProductListViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        self.getJSON(url: urlString)
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.performSegue(withIdentifier: "Home", sender: nil)
    }

    
    @IBAction func tabToChangeView(_ sender: UIButton){
        if (sender === btnLatest){
            self.viewCurrent = "Latest"
        }
        if (sender === btnCategory){
            self.viewCurrent = "Category"
        }
        if (sender === btnProvince){
            self.viewCurrent = "Province"
        }
        
        self.productListView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 44
        if(viewCurrent == "Latest" || viewCurrent == ""){
            height = 250
        }
        return height
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewCurrent == "Category"){
            return categoryList.count
        }else if(viewCurrent == "Province"){
            return provinceList.count
        }else{
            return productList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(viewCurrent == "Category"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell")
            if let cell = cell as? CategoryListCell {
                cell.labelCategoryName.text = categoryList[indexPath.row].name
                self.loadImage(cell: cell, urlPhoto: categoryList[indexPath.row].urlphoto)
            }
            return cell!
        }else if(viewCurrent == "Province"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListCell")
            if let cell = cell as? PlaceListCell {
                cell.labelProvinceName.text = provinceList[indexPath.row].name
            }

            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell")
            if let cell = cell as? ProductListCell {
                cell.labelProductName.text = productList[indexPath.row].name
                cell.labelProductAddress.text = productList[indexPath.row].address
                cell.labelScore.text = productList[indexPath.row].score
                cell.labelScore.layer.cornerRadius = cell.labelScore.frame.width/2.0
                cell.labelScore.clipsToBounds = true
                self.loadImage(cell: cell, urlPhoto: productList[indexPath.row].urlphoto)
            }
            return cell!
        }
        
    }
    
    
    func loadImage(cell: UITableViewCell, urlPhoto: String){
        weak var weakCell = cell
        let url = NSURL(string: urlPhoto)
        if url == nil {
            return
        }
        if let weakCell = weakCell as? CategoryListCell{
            weakCell.picturePreview.setImageWith(url as! URL)
        }
        if let weakCell = weakCell as? ProductListCell{
            weakCell.picturePreview.setImageWith(url as! URL)
        }
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

/*
@IBAction func submitAction(sender: AnyObject) {
    var request = URLRequest(url: URL(string: "http://anphatkhanh.vn/foody/edit.php")!)
    request.httpMethod = "POST"
    let postString = "id=13&name=Khoa&hung=334"
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            //print("error=\(error)")
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            //print("response = \(response)")
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(responseString ?? "")")
    }
    task.resume()
}
*/

