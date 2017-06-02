//
//  ProductDetailControllerViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/26/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class ProductDetailController: UIViewController {
    
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var labelProductName: UILabel!
    
    var productID: String = ""
    
    var productList  = [ProductItem]()
    let productService = ProductService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productService.fetchByID(id: productID){ [weak self] (productList, error) in
            self?.productList = productList
            DispatchQueue.main.async {
                let data = productList[0]
                self?.setUIView(data: data)
            }
            
        }
        
        //print(productList.count)
        //labelProductName.text = productList[0].name
        // Do any additional setup after loading the view.
    }
    
    func setUIView(data: ProductItem){
        labelProductName.text = data.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
