//
//  CollectionViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/29/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var btnLatestCollection: UIButton!
    @IBOutlet weak var btnMyCollection: UIButton!
    @IBOutlet weak var boundButtonMenu: UIView!
    
    var collectionList  = [CollectionItem]()
    let collectionService = CollectionService()
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var viewCurrent: String = ""
    var query: String = ""
    
    let tabMyCollection = Config().getTabMyCollection()
    let tabLatestCollection = Config().getTabLatestCollection()
    
    var productItemInfo = ProductItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        self.setUIView()
        
        collectionService.fetchAllCollection(""){ [weak self] (collectionList, error) in
            self?.collectionList = collectionList
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func setUIView(){
        
        let myButtons = boundButtonMenu.subviews.filter{$0 is UIButton}
        for button in myButtons {
            button.backgroundColor = UIColor.clear
        }
        
        if(viewCurrent == tabMyCollection ){
            btnMyCollection.backgroundColor = UIColor.white
        }
        if(viewCurrent == tabLatestCollection || viewCurrent==""){
            btnLatestCollection.backgroundColor = UIColor.white
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tabToChangeView(_ sender: UIButton){
        
        if (sender === btnMyCollection){
            if(checkLogin()) {
                print(self.getId())
                self.viewCurrent = tabMyCollection
                query += "?userID=\(self.getId())"
            }else{
                self.goToStory("Second","LoginStoryBoard")
            }
        }else if (sender === btnLatestCollection){
            query = ""
            self.viewCurrent = tabLatestCollection
            
        }
        collectionService.fetchAllCollection(query){ [weak self] (collectionList, error) in
            self?.collectionList = collectionList
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
            }
        }
        self.setUIView()
    }
    
    @IBAction func disMist(_ sender: UIButton){
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = collectionList[indexPath.row]
    
        
        productItemInfo.address = data.product_address
        productItemInfo.name = data.product_name
        productItemInfo.urlphoto = data.product_image
        productItemInfo.score = data.product_score
        productItemInfo.category_name = data.product_category_name
        productItemInfo.province_name = data.product_province_name
        productItemInfo.total_like = data.total_like
        productItemInfo.total_comment = data.total_comment
        productItemInfo.otherimage = data.product_otherimage
        productItemInfo.price =  data.product_price
        productItemInfo.category_id = data.product_category_id
        productItemInfo.id = data.product_id
        productItemInfo.province_id = data.product_province_id
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ProductDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? ProductDetailController {
            svc.productItem = self.productItemInfo
        }
    }
    @IBAction func tabToAddProduct(_ sender: UIButton){
        if checkLogin() {
            self.performSegue(withIdentifier: "AddProduct", sender: sender)
        }else{
            self.goToStory("Second","LoginStoryBoard")
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionListCell", for: indexPath) as! CollectionListCell
        let dataCollection = collectionList[indexPath.row]
        cell.loadCell(data: dataCollection, currentTab: viewCurrent)
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 2
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
