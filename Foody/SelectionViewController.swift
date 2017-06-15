//
//  SelectionViewController.swift
//  Foody
//
//  Created by Dao Quang Hung on 6/9/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary

protocol SelectionDelegate {
    func didSelect(value: Any)
}

class SelectionViewController: UIViewController{
    
    var viewCurrent: String = ""
    var provinceList = [ProductProvince]()
    var categoryList = [ProductCategory]()
    let tabCategory = Config().getTabCategory()
    let tabProvince = Config().getTabProvince()
    let tabAlbum = Config().getTabAlbum()
    
    let categoryService = CategoryService()
    let provinceService = ProvinceService()
    
    var delegate : SelectionDelegate?
    
    
    var imgManager: PHImageManager!
    var requestOptions: PHImageRequestOptions!
    var fetchOptions: PHFetchOptions!
    var fetchResult: PHFetchResult<PHAsset>!
    var resultArray = [UIImage]()
    var selectImages = [UIImage]()
    
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var tableViewSelection: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(viewCurrent == tabCategory){
            btnSelect.isHidden = true
        categoryService.fetchAllCategory(){ [weak self] (categoryList, error) in
            self?.categoryList = categoryList
            DispatchQueue.main.async {
                self?.tableViewSelection.reloadData()
            }
            
        }
        }
        if(viewCurrent == tabProvince){
            btnSelect.isHidden = true
        provinceService.fetchProvince(){ [weak self] (provinceList, error) in
            self?.provinceList = provinceList
            DispatchQueue.main.async {
                self?.tableViewSelection.reloadData()
            }
            
        }
        }
        if(viewCurrent == tabAlbum){
            btnSelect.isHidden = false
            tableViewSelection.allowsMultipleSelectionDuringEditing = true
            tableViewSelection.setEditing(true, animated: false)
            DispatchQueue.main.async {
                self.getAllPhotos()
            }
        }
        
        
              // Do any additional setup after loading the view.
    }
    
    
    
    func getAllPhotos(){
        
        imgManager = PHImageManager.default()
        requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        for index in 0..<fetchResult.count {
            imgManager.requestImage(for: fetchResult.object(at: index) as PHAsset, targetSize: UIScreen.main.bounds.size, contentMode: PHImageContentMode.aspectFill, options: requestOptions) { (image, _) in
                
                if let image = image {
                    self.resultArray.append(image)
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
    
    @IBAction func selectImage(){
        self.delegate?.didSelect(value: selectImages)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(viewCurrent == tabAlbum){
            return 200
        }else{
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(viewCurrent == tabCategory){
            self.delegate?.didSelect(value: categoryList[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }else if(viewCurrent == tabProvince){
            self.delegate?.didSelect(value: provinceList[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }else if(viewCurrent == tabAlbum){            
            selectImages.append(resultArray[indexPath.row])
            
           
        }
        //
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewCurrent == tabCategory){
            return categoryList.count
        }else if(viewCurrent == tabProvince){
            return provinceList.count
        }else if(viewCurrent == tabAlbum){
            return resultArray.count
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(viewCurrent == tabCategory){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell")
            if let cell = cell as? CategoryListCell {
                let dataCategory = categoryList[indexPath.row]
                cell.loadCell(data: dataCategory)
                
            }
            return cell!
        }else if(viewCurrent == tabProvince){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProvinceListCell")
            if let cell = cell as? ProvinceListCell {
                let dataProvince = provinceList[indexPath.row]
                cell.loadCell(data: dataProvince)
                
            }
            return cell!
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumListCell")
            if let cell = cell as? AlbumListCell {
                cell.albumImage.image = resultArray[indexPath.row]
            }

            return cell!
        }
        
    }
}
    
