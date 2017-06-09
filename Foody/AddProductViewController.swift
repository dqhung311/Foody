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
    
    @IBOutlet weak var labelTinhThanh: UILabel!
    @IBOutlet weak var labelDanhMuc: UILabel!
    
    let productService = ProductService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewAddProduct.backgroundColor = UIColor(patternImage: UIImage(named: "register-bg")!)
        btnLabel.layer.cornerRadius = 5
        btnLabel.layer.masksToBounds = true
                // Do any additional setup after loading the view.
    }
    /*
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
    */
    
    @IBAction func saveProduct(){
        let newProduct = ProductItem()
        
        newProduct.address = (txtAddress?.text)!
        newProduct.name = (txtName?.text)!
        newProduct.price = (txtPrice?.text)!
        newProduct.province_id = (txtHiddenProvince?.text)!
        newProduct.category_id = (txtHiddenCategory?.text)!
        
        productService.addNewProduct(sender: newProduct)
    }
    
    
    @IBAction func gotoSelectionView(_ sender: UIButton){
        self.performSegue(withIdentifier: "SelectionView", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) { //Ham lay screen moi .
     
        if let vc = segue.destination as? SelectionViewController {
            if let sender = sender as! UIButton? {
                if sender === btnSelectCategory {
                    vc.viewCurrent = Config().getTabCategory()
                }
                if sender === btnSelectProvince {
                    vc.viewCurrent = Config().getTabProvince()
                }
            }
        }
    }
    
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SelectionViewController {
            let indexCategory = sourceViewController.indexCategorySelected
            let indexProvince = sourceViewController.indexProvinceSelected
            
            if(indexCategory > 0){
                labelDanhMuc.text = sourceViewController.categoryList[indexCategory].name
                txtHiddenCategory.text = sourceViewController.categoryList[indexCategory].id
            }
            if(indexProvince > 0){
                labelTinhThanh.text = sourceViewController.provinceList[indexProvince].name
                txtHiddenProvince.text = sourceViewController.provinceList[indexProvince].id
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
