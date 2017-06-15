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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewOtherImage: UIView!
    @IBOutlet weak var viewCommentList: UIView!
    @IBOutlet weak var viewOtherCategoryProduct: UIView!
    @IBOutlet weak var viewOtherProvineProduct: UIView!
    
    @IBOutlet weak var scrollOtherProductView: UIScrollView!
    
    
    var heightOtherImageView: CGFloat = 0
    var heightCommentView: CGFloat = 0
    var heightOtherProductCateView: CGFloat = 0
    
    var productItem  = ProductItem()
    let productService = ProductService()
    
    var productCategoryItem  = [ProductItem]()
    
    func createViewCommentUIView(){
        var y_position = 0
        let heightLabel = 30
        let heightAvatar = 32
        let widthAvatar = 32
        let commentList = ["Gọi 2 tô hủ tiếu hoành thánh ăn đúng ngon. Nước hợp khẩu vị nên húp hết luôn. Hehe","Anh chủ rất vui tính nhé, mình sẽ quay lại khi có dịp"]
        
        for i in 0..<commentList.count {
            if (i > 0){
                y_position = y_position + heightAvatar + 8
            }else{
                y_position = 40
            }
            
            let imageView = UIImageView()
            
            imageView.loadImage(urlString: "https://media.foody.vn/usr/g8/74666/avt/c100x100/chau2201-avatar-461-636283346783431576.jpg")
            imageView.frame = CGRect(x: 8, y: y_position, width: widthAvatar, height: heightAvatar)
            imageView.layer.cornerRadius = imageView.frame.width/2.0
            imageView.clipsToBounds = true
            
            
            let label = UILabel(frame: CGRect(x: Int(widthAvatar + 15), y: Int(y_position), width: Int(UIScreen.main.bounds.width ) - (widthAvatar + 10) - 9, height: heightLabel))
            
            label.font = UIFont(name: label.font.fontName, size: 12)
            let comment = "Dao Quang Hung: \(commentList[i])"  as NSString
            let attributedString = NSMutableAttributedString(string: comment as String, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12)])
            let boldFontAttribute = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]
            attributedString.addAttributes(boldFontAttribute, range: comment.range(of: "Dao Quang Hung:"))
            label.attributedText = attributedString
            label.numberOfLines = 2
            label.sizeToFit()
           
            viewCommentList.addSubview(imageView)
            viewCommentList.addSubview(label)
        }
        self.viewCommentList.frame.size.height = CGFloat((heightLabel * commentList.count ) + 15 )
        heightCommentView = self.viewCommentList.frame.size.height
       
    }
    
    func listOtherImageUIView(view: UIView){
        let spaceLine: CGFloat = 2
        let screenSize: CGRect = UIScreen.main.bounds
        var paddingBetweenImage = Int(screenSize.width * 0.5 + spaceLine)
        var widthImage = Int(screenSize.width * 0.5)
        var heightPercent = 0.45
        var maxImageOnRow = 2
        
        var totalImage = productItem.otherimage.count
       
        if(view === viewOtherCategoryProduct){
            paddingBetweenImage = Int(screenSize.width * 0.333 + spaceLine)
            widthImage = Int(screenSize.width * 0.333)
            heightPercent = 0.25
            maxImageOnRow = 3
            totalImage = productCategoryItem.count
        }
        
        
        var row = 1
        var indexrowBreak = 0
        
        
        var heightImage = 0
        for i in 0..<totalImage{
            heightImage = Int(screenSize.width * CGFloat(heightPercent))
            var x_button = i * paddingBetweenImage
            var y_button = 0
            
            if(i != 0 && i == maxImageOnRow * row){
                indexrowBreak = 0
                row += 1
            }
            if(i >= maxImageOnRow && i <= maxImageOnRow * row) {
                x_button = indexrowBreak * paddingBetweenImage
                y_button = ((heightImage + Int(spaceLine)) / 2 * row)
                indexrowBreak += 1
            }
            if (view === viewOtherCategoryProduct){
                
                y_button += 30
                
            }
            let imageView = UIImageView()
            
            if (view === viewOtherCategoryProduct){
                imageView.loadImage(urlString: productCategoryItem[i].urlphoto)
            }else{
                imageView.loadImage(urlString: productItem.otherimage[i])
            }
            
            imageView.frame = CGRect(x: x_button, y: y_button, width: widthImage, height: heightImage)
            if (view === viewOtherCategoryProduct){
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProductDetailController.imageTapped(gesture:)))
            
            // add it to the image view;
            view.addGestureRecognizer(tapGesture)
            // make sure imageView can be interacted with by user
            imageView.isUserInteractionEnabled = true
            }
            view.addSubview(imageView)
            
            //view.isUserInteractionEnabled = false
            
            
        }
        
        view.frame.size.height = CGFloat(row * heightImage)
        if view === viewOtherImage {
            heightOtherImageView = view.frame.size.height
        }else{
            heightOtherProductCateView = view.frame.size.height
        }
    }
    
    
    func imageTapped(gesture: UIGestureRecognizer){
        //self.performSegue(withIdentifier: "AddProduct", sender: sender)
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            
        }
    
    }
    
    func createOtherProductUIView(){
        let query = "catID=\(productItem.category_id)"
        productService.fetchAllProduct(query: query){ [weak self] (productCategoryItem, error) in
            self?.productCategoryItem = productCategoryItem
            DispatchQueue.main.async {
                self?.listOtherImageUIView(view: (self?.viewOtherCategoryProduct)!)
                self?.view.addSubview((self?.scrollView)!)
            }
        }
        
    }
    
    @IBAction func tabToWriteComment(_ sender: UIButton){
        if checkLogin() {
            self.performSegue(withIdentifier: "AddComment", sender: sender)
        }else{
            self.goToStory("Second","LoginStoryBoard")
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? AddCommentViewController {
            svc.productItem = self.productItem
        }
    }
    
    
    func createOtherImageUIView(){
        self.listOtherImageUIView(view: viewOtherImage)
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
        
        self.createOtherImageUIView()
        self.createViewCommentUIView()
        self.createOtherProductUIView()
        
        
    }
    
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.viewCommentList.translatesAutoresizingMaskIntoConstraints = false
            let cnComment = NSLayoutConstraint(item: self.viewCommentList, attribute: .top, relatedBy: .equal, toItem: self.viewOtherImage, attribute: .bottom, multiplier: 1.0, constant: self.heightOtherImageView - 8)
            
            let cnProduct = NSLayoutConstraint(item: self.viewOtherCategoryProduct, attribute: .top, relatedBy: .equal, toItem: self.viewCommentList, attribute: .bottom, multiplier: 1.0, constant: self.heightCommentView + 10)
            
            self.view.addConstraint(cnComment)
            self.view.addConstraint(cnProduct)
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (self.view.frame.height + self.heightOtherImageView + self.heightCommentView + self.heightOtherProductCateView) - 50)
            
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


