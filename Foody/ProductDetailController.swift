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
    var productSelected = ProductItem()
    var productCategoryItem  = [ProductItem]()
    var productProvinceItem  = [ProductItem]()
    var refreshControl: UIRefreshControl!
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
                                let totalLike = self.productItem.total_like + 1
                                self.productItem.total_like = totalLike
                                self.labelTotalCollection.text = String(totalLike)
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
        if let svc = segue.destination as? CommentListViewController {
            svc.productItem = self.productItem
        }
        
        if let svc = segue.destination as? ProductDetailController {
            
            svc.productItem = productSelected
        }
    }
    @objc func pullToRefreshHandler() {
        // refresh table view data here
        self.loadData()
        self.refreshControl.endRefreshing()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelScore.layer.cornerRadius = labelScore.frame.width/2.0
        labelScore.clipsToBounds = true
        loadData()
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self,
                                      action: #selector(ProductDetailController.pullToRefreshHandler),
                                      for: .valueChanged)
        
        self.detailProductView.addSubview(self.refreshControl)
        //self.detailProductView.reloadData()
    }
    
    func loadData(){
        labelProductName.text = productItem.name
        labelProductNameDetail.text = productItem.name
        pictureImage.loadImage(urlString: productItem.urlphoto)
        
        
        labelTotalPicture.text = String(productItem.otherimage.count)
        labelTotalCollection.text = String(productItem.total_like)
        labelScore.text = productItem.score
        labelPrice.text = productItem.price
        labelAddress.text = productItem.address + " " + productItem.province_name
        labelCategory.text = productItem.category_name
        
        detailProductView.estimatedRowHeight = 90
        detailProductView.rowHeight = UITableViewAutomaticDimension
        
        let query = "catID=\(productItem.category_id)&exclude_id=\(productItem.id)"
        productService.fetchAllProduct(query: query){ [weak self] (productCategoryItem, error) in
            self?.productCategoryItem = productCategoryItem
            DispatchQueue.main.async {
                self?.detailProductView.reloadData()
            }
        }
        let query2 = "provinceID=\(productItem.province_id)&exclude_id=\(productItem.id)"
        productService.fetchAllProduct(query: query2){ [weak self] (productProvinceItem, error) in
            self?.productProvinceItem = productProvinceItem
            DispatchQueue.main.async {
                self?.detailProductView.reloadData()
            }
        }
        commentService.fetchAll("productID=\(productItem.id)"){ [weak self] (commentList, error) in
            self?.commentList = commentList
            DispatchQueue.main.async {
                self?.labelTotalComment.text = String(commentList.count)
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
    func onTabToViewComment(tapGesture:UITapGestureRecognizer){
        self.performSegue(withIdentifier: "ShowCommentList", sender: self)
        
    }
    
}
extension ProductDetailController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
       
        
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        header.textLabel?.frame = header.frame
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let v = UITableViewHeaderFooterView()
        if(section==1){
            let tap = UITapGestureRecognizer(target: self, action: #selector(ProductDetailController.onTabToViewComment))
            v.isUserInteractionEnabled = true
            v.addGestureRecognizer(tap)
        }
        
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section==2 || indexPath.section==3){
            if(indexPath.section==2){
                productSelected = self.productCategoryItem[indexPath.row]
            }else{
                productSelected = self.productProvinceItem[indexPath.row]
            }
            self.performSegue(withIdentifier: "ProductDetail", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section==0){
            return "::: Hình ảnh thực tế"
        }
        if(section==1){
            return "::: Bình luận (\(commentList.count))"
        }
        if(section==2){
            return "::: Cùng danh mục \(productItem.category_name)"
        }
        if(section==3){
            return "::: Cùng tỉnh thành \(productItem.province_name)"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 90
        }
        if(indexPath.section==2 || indexPath.section==3){
            return 75
        }
        return UITableViewAutomaticDimension
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
            if(commentList.count > 2){
                return 2
            }else{
                return commentList.count
            }
        }
        if(section==2){
            if(productCategoryItem.count > 3){
                return 3
            }else{
                return productCategoryItem.count
            }
            
        }
        if(section==3){
            if(productProvinceItem.count > 3){
                return 3
            }else{
                return productProvinceItem.count
            }
            
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOtherImageCell")
            
            if let cell = cell as? DetailOtherImageCell {
                cell.productItem = self.productItem
            }
            return cell!
        }else if(indexPath.section == 1){
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentListViewCell")
            
            if let cell = cell as? CommentListViewCell {
                let data = commentList[indexPath.row]
                cell.loadCell(data: data)
            }
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailOtherProductCell")
            if(indexPath.section == 3){
                 let dataProduct = productProvinceItem[indexPath.row]
                 if let cell = cell as? ProductListMangerCell {
                    cell.loadCell(data: dataProduct)
                 }
                return cell!
            }else{
                let dataProduct = productCategoryItem[indexPath.row]
                if let cell = cell as? ProductListMangerCell {
                    cell.loadCell(data: dataProduct)
                }
                return cell!
            }
            
            
            
            

        }
        
    }
    
}
