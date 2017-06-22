//
//  ProductDetailControllerViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/26/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit



class ProductDetailController: UIViewController{
    
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var labelProductNameDetail: UILabel!
    
    @IBOutlet weak var labelTotalComment: UILabel!
    @IBOutlet weak var labelTotalPicture: UILabel!
    @IBOutlet weak var labelTotalCollection: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelProvince: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    
    var productItem  = ProductItem()
    let productService = ProductService()
    let collectionService = CollectionService()
    var collectionOfUser = [CollectionItem]()
    var isHaveCollection: Bool = false
    
    var productCategoryItem  = [ProductItem]()
    
    let commentService = CommentService()
    var commentList = [Comments]()
    
    @IBOutlet weak var detailProductView: UITableView!
    
    @IBAction func tabToWriteComment(_ sender: UIButton){
        if checkLogin() {
            self.performSegue(withIdentifier: "AddComment", sender: sender)
        }else{
            self.goToStory("Second","LoginStoryBoard")
            
        }
    }
    @IBAction func tabToAddCollection(_ sender: UIButton){
        if checkLogin() {
            if(self.isHaveCollection){
                showAlertMessage("Sản phẩm này đã được lưu vào bộ sưu tập")
            }else{
                let newCollection = CollectionItem()
                newCollection.product_id = productItem.id
                newCollection.user_id = self.getId()
                
                collectionService.addNewCollection(sender: newCollection){ (result) -> Void in
                    var title = "Lỗi"
                    var success = false
                    var message = result
                    if(result == "ok"){
                        success = true
                        title = "Chúc mừng"
                        message = "Đã lưu vào bộ sưu tập thành công"
                    }
                    
                    DispatchQueue.main.async {
                        
                        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Đóng", style: .default, handler: { action in
                            if(success){
                                self.isHaveCollection = true
                            }
                        })
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                }
            }
        }else{
            self.goToStory("Second","LoginStoryBoard")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? AddCommentViewController {
            svc.productItem = self.productItem
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        labelScore.layer.cornerRadius = labelScore.frame.width/2.0
        labelScore.clipsToBounds = true
        
        
        labelProductName.text = productItem.name
        labelProductNameDetail.text = productItem.name
        pictureImage.loadImage(urlString: productItem.urlphoto)
        
        labelTotalComment.text = String(productItem.total_comment)
        labelTotalPicture.text = String(productItem.otherimage.count)
        labelTotalCollection.text = String(productItem.total_like)
        labelScore.text = productItem.score
        labelPrice.text = productItem.price
        labelAddress.text = productItem.address + " " + productItem.province_name
        labelCategory.text = productItem.category_name
        
        //detailProductView.estimatedRowHeight = 90
        detailProductView.rowHeight = UITableViewAutomaticDimension

        
        commentService.fetchAll("productID=\(productItem.id)"){ [weak self] (commentList, error) in
            self?.commentList = commentList
            DispatchQueue.main.async {
                self?.detailProductView.reloadData()
            }
        }
        
        //Check User has collection this product
        if(self.checkLogin()){
            collectionService.fetchAllCollection("?userID=\(self.getId())&action=checkUser&productID=\(productItem.id)"){ [weak self] (collectionList, error) in
                self?.collectionOfUser = collectionList
                DispatchQueue.main.async {
                    if ((self?.collectionOfUser.count)! > 0){
                        self?.isHaveCollection = true
                    }
                }
            }
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
extension ProductDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    /*func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        
            headerView.backgroundColor = UIColor.red
        
        return headerView
    }*/
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "Hình ảnh thực tế"
        }
        if(section==1){
            return "Bình luận"
        }
        if(section==2){
            return "Các sản phẩm cùng danh mục"
        }
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 90
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            if(productItem.otherimage.count > 0){
            return 1
            }else{
                return 0
            }
        }
        if(section==1){
            return commentList.count
        }
        if(section==2){
            return 3
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOtherImageCell",
                                                     for: indexPath)
            
            if let cell = cell as? DetailOtherImageCell {
                cell.productItem = self.productItem
            }
            return cell
        }else if(indexPath.section == 1){
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentListViewCell",
                                                     for: indexPath)
            if let cell = cell as? CommentListViewCell {
                let data = commentList[indexPath.row]
                cell.loadCell(data: data)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOtherProductCell",
                                                     for: indexPath)
            return cell

        }
        
    }
    
}
