//
//  CollectionManagerViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/17/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CollectionManagerViewController: UIViewController {
    @IBOutlet weak var TopAccountManager: UIView!
    @IBOutlet weak var labelWelcomeName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var productListView: UITableView!
    let tabProduct = Config().getTabProduct()
    let tabMyCollection = Config().getTabMyCollection()
    var viewCurrent: String = ""

    var collectionList  = [CollectionItem]()
    let collectionService = CollectionService()
    var productItemInfo = ProductItem()
    var productList  = [ProductItem]()
    let productService = ProductService()
    @IBOutlet weak var lblTitleFunc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelWelcomeName.text = self.getLoginName()
        avatar.loadImage(urlString: getUserImageUrl(user: nil))
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
      
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        
        TopAccountManager.backgroundColor = UIColor(patternImage: UIImage(named: "background-cover")!)
        
        if(viewCurrent==tabMyCollection){
         lblTitleFunc.text = "::: Bộ sưu tập của tôi"
            
        collectionService.fetchAllCollection("?userID=\(self.getId())"){ [weak self] (collectionList, error) in
            self?.collectionList = collectionList
            DispatchQueue.main.async {
                self?.productListView.reloadData()
            }
        }
        }
        if(viewCurrent==tabProduct){
            lblTitleFunc.text = "::: Sản phẩm của tôi"
            
        productService.fetchAllProduct(query: "userID=\(self.getId())"){ [weak self] (productList, error) in
            self?.productList = productList
            DispatchQueue.main.async {
                self?.productListView.reloadData()
            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? ProductDetailController {
            svc.productItem = self.productItemInfo
        }
    }

}

extension CollectionManagerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //var height: CGFloat = 44
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(viewCurrent==tabProduct){
          
            productItemInfo.address = productList[indexPath.row].address
            productItemInfo.name = productList[indexPath.row].name
            productItemInfo.urlphoto = productList[indexPath.row].urlphoto
            productItemInfo.score = productList[indexPath.row].score
            productItemInfo.category_name = productList[indexPath.row].category_name
            productItemInfo.province_name = productList[indexPath.row].province_name
            productItemInfo.total_like = productList[indexPath.row].total_like
            productItemInfo.total_comment = productList[indexPath.row].total_comment
            productItemInfo.otherimage = productList[indexPath.row].otherimage
            productItemInfo.price =  productList[indexPath.row].price
            productItemInfo.category_id = productList[indexPath.row].category_id

        }else{
            
            productItemInfo.address = collectionList[indexPath.row].product_address
            productItemInfo.name = collectionList[indexPath.row].product_name
            productItemInfo.urlphoto = collectionList[indexPath.row].product_image
            productItemInfo.score = collectionList[indexPath.row].product_score
            productItemInfo.category_name = collectionList[indexPath.row].product_category_name
            productItemInfo.province_name = collectionList[indexPath.row].product_province_name
            productItemInfo.total_like = collectionList[indexPath.row].total_like
            productItemInfo.total_comment = collectionList[indexPath.row].total_comment
            productItemInfo.otherimage = collectionList[indexPath.row].product_otherimage
            productItemInfo.price =  collectionList[indexPath.row].product_price
            productItemInfo.category_id = collectionList[indexPath.row].product_category_id
        }
        
        
        
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ProductDetailStoryBoard", sender: self)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewCurrent == tabMyCollection) {
            return collectionList.count
        }else {
            return productList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListMangerCell")
        
        if let cell = cell as? ProductListMangerCell {
            var data: Any = ""
            if viewCurrent == tabMyCollection {
                 data = collectionList[indexPath.row]
            }else {
                 data = productList[indexPath.row]
            }
            
            cell.loadCell(data: data)
        }
        return cell!
        
    }
}
