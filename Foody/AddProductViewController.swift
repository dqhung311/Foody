//
//  AddProductViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/7/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var viewAddProduct: UIView!
    @IBOutlet weak var btnLabel: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    
    @IBOutlet weak var txtHiddenProvince: UITextField!
    @IBOutlet weak var txtHiddenCategory: UITextField!
    
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var pickerProvince: UIPickerView!
    
    var provinceList = [ProductProvince]()
    var categoryList = [ProductCategory]()
    
    let productService = ProductService()
    
    let list = ["1","2","4","5"]
    let categoryService = CategoryService()
    let provinceService = ProvinceService()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewAddProduct.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
        
        
        categoryService.fetchAllCategory(){ [weak self] (categoryList, error) in
            self?.categoryList = categoryList
            DispatchQueue.main.async {
                self?.pickerCategory.reloadAllComponents()
            }
            
        }
        provinceService.fetchProvince(){ [weak self] (provinceList, error) in
            self?.provinceList = provinceList
            DispatchQueue.main.async {
                self?.pickerProvince.reloadAllComponents()
            }
        }
        
        // Do any additional setup after loading the view.
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView === pickerCategory {
            return categoryList.count
        }else{
            return provinceList.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        if pickerView === pickerCategory {
            titleData = categoryList[row].name
        }else{
            titleData = provinceList[row].name
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
            
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //titleForRow.setValue(UIColor.white, forKeyPath: "textColor")
        self.view.endEditing(true)
        if pickerView === pickerCategory {
            return categoryList[row].name
        }else{
            return provinceList[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       if pickerView === pickerCategory {
        self.txtCategory.text = self.categoryList[row].name
        self.txtHiddenCategory.text = self.categoryList[row].id
        self.pickerCategory.isHidden = true
        self.pickerCategory.frame.size.height = 0
       }else{
        self.txtProvince.text = self.provinceList[row].name
        self.txtHiddenProvince.text = self.provinceList[row].id
        self.pickerProvince.isHidden = true
        self.pickerProvince.frame.size.height = 0
        }
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.txtCategory {
            self.pickerCategory.isHidden = false
            self.pickerProvince.isHidden = true
            self.pickerCategory.frame.size.height = 100
            //if you dont want the users to se the keyboard type:
            
        }
        if textField == self.txtProvince {
            self.pickerProvince.isHidden = false
            self.pickerCategory.isHidden = true
            self.pickerProvince.frame.size.height = 100
            //if you dont want the users to se the keyboard type:
        }
        
        textField.endEditing(true)
        
    }
    
    @IBAction func saveProduct(){
        let newProduct = ProductItem()
        
        newProduct.address = (txtAddress?.text)!
        newProduct.name = (txtName?.text)!
        newProduct.price = (txtPrice?.text)!
        newProduct.province_id = (txtHiddenProvince?.text)!
        newProduct.category_id = (txtHiddenCategory?.text)!
        
        productService.addNewProduct(sender: newProduct)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func disMist(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }

}
