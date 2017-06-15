//
//  AddProductViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/7/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit


class AddProductViewController: UIViewController{
    @IBOutlet weak var viewAddProduct: UIView!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    
    @IBOutlet weak var txtHiddenProvince: UITextField!
    @IBOutlet weak var txtHiddenCategory: UITextField!
    
    @IBOutlet weak var btnSelectCategory: UIButton!
    @IBOutlet weak var btnSelectProvince: UIButton!
    @IBOutlet weak var btnSelectAlbum: UIButton!
    
    @IBOutlet weak var labelTinhThanh: UILabel!
    @IBOutlet weak var labelDanhMuc: UILabel!
    @IBOutlet weak var labelHinhAnh: UILabel!
    
    let productService = ProductService()
    
    var listImage = [UIImage]()
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewAddProduct.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        activity.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveProduct(){
        activity.isHidden = false
        activity.startAnimating()
        let newProduct = ProductItem()
        newProduct.address = (txtAddress?.text)!
        newProduct.name = (txtName?.text)!
        newProduct.price = (txtPrice?.text)!
        newProduct.province_id = (txtHiddenProvince?.text)!
        newProduct.category_id = (txtHiddenCategory?.text)!
        productService.addNewProduct(sender: newProduct,imagesdata: listImage){ (result) -> Void in
            var title = "Lỗi"
            var dismiss = false
            var message = result
            if(result == "ok"){
                dismiss = true
                title = "Chúc mừng"
                message = "Đăng sản phẩm thành công"
            }
            
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Đóng", style: .default, handler: { action in
                    if(dismiss){
                        self.dismiss(animated: true, completion: nil)
                    }
                })
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                self.activity.isHidden = true
            }
            
        }
    
    
    }
    
    
    
    @IBAction func gotoSelectionView(_ sender: UIButton){
        self.performSegue(withIdentifier: "SelectionView", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) { //Ham lay screen moi .
     
        if let vc = segue.destination as? SelectionViewController {
            vc.delegate = self
            if let sender = sender as! UIButton? {
                if sender === btnSelectCategory {
                    vc.viewCurrent = Config().getTabCategory()
                }
                if sender === btnSelectProvince {
                    vc.viewCurrent = Config().getTabProvince()
                }
                if sender === btnSelectAlbum {
                    vc.viewCurrent = Config().getTabAlbum()
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

extension AddProductViewController : SelectionDelegate {
    func didSelect(value: Any) {
        if let value = value as? ProductCategory {
            labelDanhMuc.text = value.name
            txtHiddenCategory.text = value.id
        }
        if let value = value as? ProductProvince {
            labelTinhThanh.text = value.name
            txtHiddenProvince.text = value.id
        }
        
        if let value = value as? [UIImage] {
            labelHinhAnh.text = "Hình ảnh (" + String(value.count) + ")"
            listImage = value
        }
        
    }
}
